# boxandparallel

The app without box can be run manually from `app_one_file_whole.R`, <kbd>Ctrl</kbd> + <kbd>A</kbd>     <kbd>Ctrl</kbd> <kbd>Enter</kbd>

The several files app can run with

```
shiny::runApp()
```

after changes, run
```
rm(list = ls(box:::loaded_mods), envir = box:::loaded_mods) 
```

As this is currently solved, the `go_parallel` constant is `TRUE`, it runs the parallel code, in `second_module.R`
