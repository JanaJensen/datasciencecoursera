#############################
# why is my code so slow?
#############################

# Profiling is a systematic way to examine time spent by a program
# Useful for optimizing

# General principles of optimization:
#   - design first, then optimize
#   - premature optimization is the root of all evil
#   - measure (collect data), don't guess
#   - apply scientific prinicples to coding


#############################
# system.time() - when you know where the problem is and want to measure
#############################

# returns the amount of time taken to evaluate the expression
#   - class proc_time
#   - user time = time charged to the CPUs
#   - elapsed time = wall clock time
#
# functions that take advantage of mutiple cores:
#   - multi-threaded BLAS libraries(vecLib/Accelerate, ATLAS, ACML, MKL)
#   - parallel package


# elapsed time > user time (time to transport data over network)
system.time(readLines("http://www.jhsph.edu"))


# elapsed time < user time
hilbert <- function(n) {
    i <- 1:n
    1/outer(i-1,i,"+")
}
x <- hilbert(1000)
system.time(svd(x))  # umm, on my computer elapsed is still greater


# longer expressions, use curly braces
system.time({
    n <- 1000
    r <- numeric(n)
    for(i in 1:n) {
        x <- rnorm(n)
        r[i] <- mean(x)
    }
})


#############################
# R Profiler - finding where the problem is
#############################

# Rprof() starts the profiler (assuming R was compiled with profiler support)
# summaryRprof() gives readable results
#
# DO NOT use Rprof() and system.time() together
#
# Rprof() tracks the function call stack at sampled intervals and tabulates
# time spent in each function
#
# Summary format gives self time, self %, total time, total %, sample interval, sampling time
#   - total includes time spent in subcalls
#       - e.g. top level function always in use 100% of the time
#   - self does not incl subcalls, only local ops
#
# by.total orders the summary output by total time desc
# by.self orders the summary output by self time desc
#
# If you break your code into functions, profiler details more useful
# C or Fortran calls are not profiled, included in the time for the calling R function

Rprof()       # turn profiler on
fit <- lm(y ~ x1 + x2)
Rprof(NULL)  # turn profiler off
