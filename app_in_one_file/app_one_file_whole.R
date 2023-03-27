library(shiny)
library(shinydashboard)
library(doParallel)
library(foreach)
# install.packages("shinydashboard")

first_module_ui <- function(id) {
  ns <- NS(id)
  tagList(
    box(title = "First Module", collapsible = TRUE,
        solidHeader = TRUE, status = "primary",
        width = 4, height = "400px",
        fluidRow(
          column(6, numericInput(ns("input_1"), "module1input", 4, 1, max = 10 )),
          column(6, textOutput(ns("output_1")))
        )
    )
  )
}

first_module_server <- function(id) {
  moduleServer(id, function(input, output, session) {

    output$output_1 <- renderText({
      paste("first module selection:",input$input_1)
    })
    return(reactive(input$input_1))
  }
)}


second_module_ui <- function(id) {
  ns <- NS(id)
  tagList(
    box(title = "Second Module", collapsible = TRUE,
        solidHeader = TRUE, status = "success",
        width = 4, height = "400px",
        fluidRow(
          column(6, numericInput(ns("input_2"), "module2input", 9, 1, max = 10 )),
          column(6, textOutput(ns("output_2")))
        )
    )
  )
}

second_module_server <- function(id, first_vars) {
  moduleServer(id, function(input, output, session) {

    output$output_2 <- renderText({
      cl <- parallel::makeCluster(2)
      doParallel::registerDoParallel(cl)

      myset <- c(first_vars(), input$input_2)

      result <- foreach(i = myset, .combine = 'c') %dopar% {
        sqrt(i)
      }

      parallel::stopCluster(cl)

      paste("sqrt(s):", result, collapse = ", ")
    })
  }
)}

ui <- fluidPage(
  first_module_ui("first"),
  second_module_ui("second")
)

server <- function(input, output, session) {
  first_vars <- first_module_server("first")
  second_module_server("second", first_vars)
}

shinyApp(ui, server)
