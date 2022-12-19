#' Shiny App Function
#'
#' This function uses imported HRV data to generate a shiny app. Within the shiny app, the user can specify
#' the time segment that they are interested in, and generate time domain HRV statistics based on that time segment.
#' Within the app, time segments are specified to two decimal spaces (i.e., 3.50).
#'
#' @param imported_data Imported csv file containing a single column of MS or RR values.
#' @param input Specify if the data imported data contains MS or RR values.
#' @return Shiny
#' @export


# Shiny Function
HRV_Shiny <- function (imported_data, input) {
  data <- TimeDomainHRV::Data_Input(imported_data = imported_data, input = input, segment = FALSE)
  mi <- min(round(data[,1], digits = 2))
  ma <- max(round(data[,1], digits = 2))

  # Shiny Script
  # User Interface
  ui <- shiny::pageWithSidebar(
    shiny::headerPanel(title = "Time Domain Heart Rate Variation Analysis"),

    # Making a sidebar where the user can indicate the specific time they are interested in
    # and a checklist where they can index what statistics they would like to be reported on
    # the specified time frame.
    shiny::sidebarPanel((" "),
               shiny::numericInput("minId", "Minimum Time (0.00)", mi, min = mi, max = ma, width = NULL),
               shiny::numericInput("maxId", "Maximum Time (0.00)", ma, min = mi, max = ma, width = NULL),
               shiny::checkboxGroupInput("statId", "Statistics:",
                                  choices = c("Min","Max","Mean", "Range", "RMSSD", "SDNN",
                                              "NN50", "pNN50"))
  ),
  # The plot and the statistics should be on the main panel / right side of the app.
  shiny::mainPanel(
    shiny::fluidRow(
      plotly::plotlyOutput("plot1"),
      shinydashboard::box(
        title = "Statistics Output",
        shiny::tableOutput('StatisticsOutput')
      )
    )
  )
)

# Server
server <- function(input, output) {
  # Scatter plot output
  output$plot1 <- plotly::renderPlotly({
    data$Minutes <- round(data$Minutes, digits = 2)
    min_val <- input$minId
    max_val <- input$maxId
    min_row <- which(data$Minutes == min_val)
    max_row <- which(data$Minutes == max_val)
    constrained_data <- as.data.frame(data[min_row:max_row, 1:2])
    plot <- plotly::plot_ly(constrained_data, x = constrained_data$Minutes,
                    y = constrained_data$RR, type = "scatter", mode = "markers")
  })

  # Statistics Table Calculations and Output
  output$StatisticsOutput <- shiny::renderTable({
    
    # Specifying the min/max values that should be applied to the data before
    # calculating statistics
    data$Minutes <- round(data$Minutes, digits = 2)
    min_val <- input$minId
    max_val <- input$maxId
    min_row <- which(data$Minutes == min_val)
    max_row <- as.numeric(which(data$Minutes == max_val))
    constrained_data <- as.data.frame(data[min_row:max_row, 1:2])
    constrained_RR <- constrained_data$RR
    table <- data.frame(matrix(ncol = 2, nrow = 0, dimnames = list (NULL, c("Statistics", "Value"))))
    
    if ('Min' %in% input$statId) {
      min_stat <- data.frame("Statistics" = "Min", "Value" = min(constrained_RR))
      table <- rbind(table, min_stat)}

    if ('Max' %in% input$statId) {
      max_stat <- data.frame("Statistics" = "Max", "Value" = max(constrained_RR))
      table <- rbind (table, max_stat)
    }

    if ('Mean' %in% input$statId) {
      mean_stat <- mean(constrained_RR)
      mean_stat <- data.frame("Statistics" = "Mean", "Value" = mean_stat)
      table <- rbind(table, mean_stat)
    }

    if ('Range' %in% input$statId) {
      range_stat <- max(constrained_RR) - min(constrained_RR)
      range_stat  <- data.frame("Statistics" = "Range", "Value" = range_stat)
      table <- rbind(table, range_stat)
    }

    if ('RMSSD' %in% input$statId) {
      RMSSD <- TimeDomainHRV::RMSSD(constrained_data)
      RMSSD  <- data.frame("Statistics" = "RMSSD", "Value" = RMSSD)
      table <- rbind(table, RMSSD)
    }

    if ('SDNN' %in% input$statId) {
      SDNN <- TimeDomainHRV::SDNN(constrained_data)
      SDNN  <- data.frame("Statistics" = "SDNN", "Value" = SDNN)
      table <- rbind(table, SDNN)
    }

    if ('NN50' %in% input$statId) {
      NN50 <- TimeDomainHRV::NN50_Count(constrained_data)
      NN50  <- data.frame("Statistics" = "NN50", "Value" = NN50)
      table <- rbind(table, NN50)
    }

    if ('pNN50' %in% input$statId) {
      pNN50 <- TimeDomainHRV::pNN50_Percentage(constrained_data)
      pNN50  <- data.frame("Statistics" = "pNN50", "Value" = pNN50)
      table <- rbind(table, pNN50)
    }

    table

  })

}

shiny::shinyApp(ui, server)

}


