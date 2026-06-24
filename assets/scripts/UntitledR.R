# Load required libraries
library(XML)
library(httr)
library(stringr)
library(tidyverse)
library(jsonlite)

# Function to extract UniProt IDs from MIRIAM annotations
extract_uniprot_ids <- function(species_node) {
  ns <- c(
    rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
    bqbiol = "http://biomodels.net/biology-qualifiers/"
  )
  
  uniprot_refs <- xpathSApply(species_node, 
                              ".//bqbiol:hasPart//rdf:li/@resource", 
                              namespaces = ns)
  
  uniprot_ids <- str_extract(uniprot_refs, "(?<=uniprot:)[A-Za-z0-9]+$")
  return(unique(uniprot_ids[!is.na(uniprot_ids)]))
}

# Function to create UniProt to HGNC mapping
create_uniprot_mapping <- function(uniprot_ids) {
  base_url <- "https://rest.uniprot.org/uniprotkb/search?format=json&fields=accession,gene_names&query="
  batch_size <- 30  # Reduced batch size for safety
  batches <- split(uniprot_ids, ceiling(seq_along(uniprot_ids)/batch_size))
  
  mapping_df <- data.frame(UniProt=character(), HGNC=character(), stringsAsFactors=FALSE)
  
  message("Fetching HGNC symbols from UniProt...")
  
  for(batch in batches) {
    query <- paste0("accession:", paste(batch, collapse=" OR "))
    url <- paste0(base_url, URLencode(query))
    
    tryCatch({
      response <- GET(url)
      if(status_code(response) == 200) {
        data <- fromJSON(rawToChar(response$content))
        if(!is.null(data$results) && nrow(data$results) > 0) {
          for(i in 1:nrow(data$results)) {
            result <- data$results[i, ]
            uniprot_id <- result$primaryAccession
            gene_name <- uniprot_id  # Default fallback
            
            if(!is.null(result$genes[[1]])) {
              if(!is.null(result$genes[[1]]$geneName$value)) {
                gene_name <- result$genes[[1]]$geneName$value
              }
            }
            
            mapping_df <- rbind(mapping_df, 
                                data.frame(UniProt=uniprot_id, 
                                           HGNC=gene_name, 
                                           stringsAsFactors=FALSE))
          }
        }
      } else {
        warning("Failed to fetch batch: HTTP ", status_code(response))
      }
    }, error = function(e) {
      warning("Error fetching batch: ", e$message)
    })
    
    Sys.sleep(1)  # Increased delay
  }
  
  return(mapping_df)
}

# Function to convert UniProt ID to HGNC symbol
uniprot_to_hgnc <- function(uniprot_id, mapping_df) {
  if (missing(mapping_df) || is.null(mapping_df)) return(uniprot_id)
  hgnc <- mapping_df$HGNC[mapping_df$UniProt == uniprot_id]
  ifelse(length(hgnc) > 0, hgnc[1], uniprot_id)
}

# Function to create protein element
create_protein_element <- function(doc, protein_info) {
  protein <- newXMLNode("celldesigner:protein",
                        attrs = c(
                          id = protein_info$id,
                          name = protein_info$name,
                          type = "GENERIC"
                        ))
  
  if (length(protein_info$modifications) > 0) {
    mods <- newXMLNode("celldesigner:listOfModificationResidues", parent = protein)
    for (mod in protein_info$modifications) {
      newXMLNode("celldesigner:modificationResidue",
                 attrs = c(
                   angle = "0.0",
                   id = mod$id,
                   name = mod$residue,
                   side = "none"
                 ),
                 parent = mods)
    }
  }
  return(protein)
}

# Function to process modification annotations
extract_modifications <- function(species_node) {
  name <- xmlGetAttr(species_node, "name")
  mods <- list()
  
  # Expanded pattern matching
  phos_sites <- str_extract_all(name, "(p|phospho)[-_]?([STA-Y][0-9]+)", simplify = TRUE)[,2]
  if(length(phos_sites) > 0) {
    mods <- lapply(seq_along(phos_sites), function(i) {
      list(
        id = paste0("mod", i),
        type = "phosphorylation",
        residue = phos_sites[i]
      )
    })
  }
  return(mods)
}

# Main processing function
process_sbml <- function(input_file, output_file, mapping_file = NULL) {
  namespaces <- c(
    sbml = "http://www.sbml.org/sbml/level2/version4",
    celldesigner = "http://www.sbml.org/2001/ns/celldesigner",
    rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
    bqbiol = "http://biomodels.net/biology-qualifiers/"
  )
  
  tryCatch({
    doc <- xmlParse(input_file)
    model <- getNodeSet(doc, "//sbml:model", namespaces = namespaces)[[1]]
    
    # Ensure extension exists
    extension <- getNodeSet(doc, "//celldesigner:extension", namespaces = namespaces)
    if (length(extension) == 0) {
      extension <- newXMLNode("celldesigner:extension", parent = model)
    } else {
      extension <- extension[[1]]
    }
    
    # Ensure listOfProteins exists
    proteins_list <- getNodeSet(extension, "./celldesigner:listOfProteins")
    if (length(proteins_list) == 0) {
      proteins_list <- newXMLNode("celldesigner:listOfProteins", parent = extension)
    } else {
      proteins_list <- proteins_list[[1]]
    }
    
    species_nodes <- getNodeSet(doc, "//sbml:species", namespaces = namespaces)
    all_uniprot_ids <- unique(unlist(lapply(species_nodes, extract_uniprot_ids)))
    
    mapping_df <- if (!is.null(mapping_file) && file.exists(mapping_file)) {
      read.delim(mapping_file, stringsAsFactors = FALSE)
    } else {
      mapping <- create_uniprot_mapping(all_uniprot_ids)
      if (!is.null(mapping_file)) write.table(mapping, mapping_file, sep = "\t", row.names = FALSE)
      mapping
    }
    
    # Process each species
    for (species in species_nodes) {
      species_id <- xmlGetAttr(species, "id")
      uniprot_ids <- extract_uniprot_ids(species)
      
      if (length(uniprot_ids) > 0) {
        uniprot_id <- uniprot_ids[1]  # Use first UniProt ID
        hgnc_symbol <- uniprot_to_hgnc(uniprot_id, mapping_df)
        
        # Generate unique protein ID
        protein_id <- paste0(species_id, "_protein")
        
        # Check if protein already exists
        existing <- getNodeSet(proteins_list, paste0("./celldesigner:protein[@id='", protein_id, "']"))
        if (length(existing) > 0) next  # Skip if already processed
        
        # Create protein
        protein_info <- list(
          id = protein_id,
          name = hgnc_symbol,
          modifications = extract_modifications(species)
        )
        protein_node <- create_protein_element(doc, protein_info)
        addChildren(proteins_list, protein_node)
        
        # Update species annotation
        annotation <- getNodeSet(species, "./sbml:annotation", namespaces = namespaces)
        if (length(annotation) == 0) {
          annotation <- newXMLNode("annotation", parent = species)
        } else {
          annotation <- annotation[[1]]
        }
        
        species_anno <- getNodeSet(annotation, "./celldesigner:speciesAnnotation")
        if (length(species_anno) == 0) {
          species_anno <- newXMLNode("celldesigner:speciesAnnotation", 
                                     attrs = c(species = species_id),
                                     parent = annotation)
        } else {
          species_anno <- species_anno[[1]]
        }
        
        protein_ref <- getNodeSet(species_anno, "./celldesigner:proteinReference")
        if (length(protein_ref) == 0) {
          newXMLNode("celldesigner:proteinReference", protein_id, parent = species_anno)
        } else {
          xmlValue(protein_ref[[1]]) <- protein_id
        }
      }
    }
    
    saveXML(doc, output_file)
    message("Successfully processed: ", output_file)
    
  }, error = function(e) {
    stop("Processing failed: ", e$message)
  })
}

# Usage example:
process_sbml("R-HSA-75035.xml", "output.xml", "uniprot_hgnc_mapping.txt")
