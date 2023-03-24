# Define the app
box::use(
  shiny[...],
  shinydashboard[...],
  doParallel[...],
  foreach[...],
  ./first_module,
  ./second_module
)

ui <- fluidPage(
  first_module$ui("first"),
  second_module$ui("second")
)

# RUN app with
# shiny::runApp()
# after changes, run
#rm(list = ls(box:::loaded_mods), envir = box:::loaded_mods) 
