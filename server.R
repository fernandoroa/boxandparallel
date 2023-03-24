# Define the app
box::use(
  ./first_module,
  ./second_module
)


server <- function(input, output, session) {
  first_vars <- first_module$server("first")
  second_module$server("second", first_vars)
}

# RUN app with
# shiny::runApp()
# after changes, run
#rm(list = ls(box:::loaded_mods), envir = box:::loaded_mods) 
