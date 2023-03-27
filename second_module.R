box::use(
  shiny[...],
  shinydashboard[...],
  parallel,
  dp = doParallel,
  foreach[foreach, `%dopar%`],
  ./first_module
)
#' @export
ui <- function(id) {
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

#' @export
server <- function(id, first_vars) {
  moduleServer(id, function(input, output, session) {

    output$output_2 <- renderText({
        cl <- parallel::makeCluster(2)
        dp$registerDoParallel(cl)

        myset <- c(first_vars(), input$input_2)
        go_parallel <- FALSE
        # parallel$clusterExport(cl, "first_module$run_sqrt")
        if (go_parallel) {
            result <- foreach(i = myset, .combine = 'c') %dopar% {
                first_module$run_sqrt(i)
            }
        } else {
            result <- first_module$run_sqrt(myset)
        }

        parallel::stopCluster(cl)

        paste("sqrt(s):", result, collapse = ", ")
    })
  }
)}