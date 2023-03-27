box::use(
  ./mod[...],
  parallel,
  dp = doParallel,
  foreach[foreach, `%dopar%`],
)

cl <- parallel$makeCluster(2L)
dp$registerDoParallel(cl)

foreach(i = 1 : 5) %dopar% {
  run_sqrt(i)
}

parallel$stopCluster(cl)