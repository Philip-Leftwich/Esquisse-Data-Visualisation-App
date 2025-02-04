library(shiny)
library(esquisse)
library(colorBlindness)# For colorblind simulation
library(ggplot2)
library(plotly)

ui <- fluidPage(
  theme = bs_theme_esquisse(),
  
  tags$h1("Upload CSV and Visualize with Esquisse"),
  
  uiOutput("file_input_ui"),  # Render file input dynamically
  actionButton('reset', 'Reset Data'),
  verbatimTextOutput("summary"),
  
  checkboxGroupInput(
    inputId = "aes",
    label = "Aesthetics to use:",
    choices = c("fill", "color", "size", "shape", "weight", "group", "facet", "facet_row", "facet_col"),
    selected = c("fill", "color", "size", "facet"),
    inline = TRUE
  ),
  
  checkboxInput("cvd_check", "Colorblind-friendly View", value = FALSE),  # New checkbox
  
  esquisse_ui(
    id = "esquisse",
    header = FALSE,
    container = esquisse_container(height = "700px")
  ),
  
  tags$b("Output of the module:"),
  verbatimTextOutput("out"),
  
  plotOutput("cvd_plot")  # New plot output
)

server <- function(input, output, session) {
  data_rv <- reactiveValues(data = iris, name = "iris")
  
  output$file_input_ui <- renderUI({
    fileInput('datafile', 'Choose CSV File',
              accept = c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
  })
  
  values <- reactiveValues(
    upload_state = "default"
  )
  
  observeEvent(input$datafile, {
    req(input$datafile)
    tryCatch({
      data_rv$data <- read.csv(input$datafile$datapath)
      data_rv$name <- "data"
      values$upload_state <- 'uploaded'
    }, error = function(e) {
      showNotification("Error reading CSV file", type = "error")
    })
  })
  
  observeEvent(input$reset, {
    data_rv$data <- iris  # Reset to default iris dataset
    data_rv$name <- "iris"
    values$upload_state <- 'reset'
    
    # Re-render the file input to clear the uploaded file
    output$file_input_ui <- renderUI({
      fileInput('datafile', 'Choose CSV File',
                accept = c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
    })
  })
  
  output$summary <- renderText({
    if (values$upload_state == 'uploaded') {
      paste("Uploaded file:", input$datafile$name)
    } else {
      paste("Default file:", input$datafile$name)
    }
  })
  
  esquisse_out <- esquisse_server(
    id = "esquisse",
    data_rv = data_rv,
    default_aes = reactive(input$aes)
  )
  
  output$out <- renderPrint({
    str(reactiveValuesToList(esquisse_out), max.level = 1)
  })
  
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


