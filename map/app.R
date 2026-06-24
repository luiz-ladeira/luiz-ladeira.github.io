# Load required libraries
library(shiny)

# Define UI for the Shiny app
ui <- fluidPage(
  titlePanel("Google Colab Notebook Viewer"),
  mainPanel(
    tags$iframe(
      src = "https://colab.research.google.com/drive/17NKp-VWvVPjSlXYh_NFYCcjTMOfLNuZD?usp=sharing",
      width = "100%",
      height = "800px",
      style = "border: none;"
    )
  )
)

# Define server logic (no server-side logic needed for this example)
server <- function(input, output, session) {}

# Run the Shiny app
shinyApp(ui = ui, server = server)