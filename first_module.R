box::use(
  shiny[...],
  shinydashboard[...],
)
#' @export
ui <- function(id) {
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

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    output$output_1 <- renderText({
      paste("first module selection:",input$input_1)
    })
    return(reactive(input$input_1))
  }
)}

#' @export
run_sqrt <- function(number) {
    sqrt(number)
}