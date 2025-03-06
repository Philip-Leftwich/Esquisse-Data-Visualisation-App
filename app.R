library(shiny)
library(esquisse)
library(colorBlindness)# For colorblind simulation
library(ggplot2)
library(plotly)

ui <- fluidPage(
  
  theme = bs_theme_esquisse(),
  
  tags$h1("Upload CSV and Visualize with Esquisse"),
  
  
  
  checkboxGroupInput(
    inputId = "aes",
    label = "Aesthetics to use:",
    choices = c("fill", "color", "size", "shape", "weight", "group", "facet", "facet_row", "facet_col", "label"),
    selected = c("fill", "color", "size", "facet"),
    inline = TRUE
  ),
  
  checkboxInput("cvd_check", "Colorblind-friendly View", value = FALSE),  # New checkbox
  
  esquisse_ui(
    id = "esquisse",
    header = esquisse_header(),
    n_geoms = 4,
    container = esquisse_container(height = "700px")
  ),
  
  
  plotOutput("cvd_plot")  # New plot output
)

server <- function(input, output, session) {
  
  
  data_rv <- reactiveValues(data = iris, name = "iris")
  
  observeEvent(iris, {
    data_rv$data <- iris
    data_rv$name <- "iris"
  })
  
  
  esquisse_out <- esquisse_server(
    id = "esquisse",
    n_geoms = 4,
    data_rv = data_rv,
    
  )
  
  output$cvd_plot <- renderPlot({
    req(input$cvd_check)  # Only render if checkbox is checked
    data <- data_rv$data
    plot_code <- esquisse_out$code_plot
    
    if (!is.null(plot_code) && plot_code != "") {
      plot_obj <- eval(parse(text = plot_code))  # Convert code to ggplot object
      cvdPlot(plot_obj)        # Simulate Deuteranopia
    }
  })
  
  
}

shinyApp(ui, server)


