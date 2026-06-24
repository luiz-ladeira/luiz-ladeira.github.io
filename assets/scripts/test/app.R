library(shiny)
library(visNetwork)
library(readxl)
library(dplyr)
library(stringr)

# Load and preprocess data
df <- read_excel("data.xlsx")

# Process nodes
upstream_nodes <- data.frame(
  name = df$KE_upstream,
  aop_id = as.integer(df$KE_upstream_AOP_Wiki_ID),
  color = df$KE_up_color,
  type = df$KE_up_type
)

downstream_nodes <- data.frame(
  name = df$KE_downstream,
  aop_id = as.integer(df$KE_downstream_AOP_Wiki_ID),
  color = df$KE_down_color,
  type = df$KE_down_type
)

all_nodes <- bind_rows(upstream_nodes, downstream_nodes)
nodes <- all_nodes %>%
  distinct(name, .keep_all = TRUE) %>%
  mutate(
    shape = case_when(
      type == "Pathway" ~ "circle",
      type == "AO" ~ "square",
      type == "MIE" ~ "triangle",
      type == "KE" ~ "diamond",
      TRUE ~ "ellipse"
    ),
    title = paste0("<a href='https://aopwiki.org/events/", aop_id, "' target='_blank'>AOP Wiki</a>"),
    id = name,
    size = 20,  # Fixed node size
    font = list(size = 12)  # Adjust font size for better readability
  )

# Process edges
edges <- df %>%
  mutate(
    from = KE_upstream,
    to = KE_downstream,
    pmid_num = str_extract(PMID, "\\d+"),
    dashes = ifelse(Adjacency == "adjacent", FALSE, TRUE),
    title = paste0(
      "PubMed: <a href='https://pubmed.ncbi.nlm.nih.gov/", pmid_num, "' target='_blank'>", pmid_num, "</a>",
      ifelse(!is.na(WoE) & WoE != "", paste0("<br>WoE: ", WoE), ""),
      ifelse(!is.na(Quantitative_understanding) & Quantitative_understanding != "", 
             paste0("<br>Quantitative: ", Quantitative_understanding), "")
    )
  ) %>%
  select(from, to, title, dashes)

# Shiny App
ui <- fluidPage(
  titlePanel("AOP Network Visualization"),
  visNetworkOutput("network", height = "800px")
)

server <- function(input, output) {
  output$network <- renderVisNetwork({
    visNetwork(nodes, edges) %>%
      visNodes(
        color = list(background = nodes$color, border = "black"),
        shape = nodes$shape,
        size = nodes$size,  # Fixed size for all nodes
        font = nodes$font,  # Adjust font size
        shadow = TRUE
      ) %>%
      visEdges(
        arrows = "to",
        smooth = FALSE
      ) %>%
      visPhysics(
        solver = "repulsion",  # Use repulsion solver for better spacing
        repulsion = list(
          nodeDistance = 200,  # Increase node distance
          centralGravity = 0.1,
          springLength = 200,
          springConstant = 0.05,
          damping = 0.09
        ),
        stabilization = list(
          enabled = TRUE,
          iterations = 1000,
          updateInterval = 100
        )
      ) %>%
      visLayout(randomSeed = 123) %>%
      visOptions(
        highlightNearest = list(enabled = TRUE, degree = 1),
        nodesIdSelection = TRUE
      ) %>%
      visInteraction(
        tooltipStyle = "position: fixed; visibility:hidden; padding: 5px;
                        background-color: #f5f4ed;
                        border: 1px solid #808080;
                        border-radius: 3px;",
        dragNodes = TRUE,  # Allow manual node dragging
        dragView = TRUE,   # Allow panning
        zoomView = TRUE    # Allow zooming
      )
  })
}

shinyApp(ui = ui, server = server)