#############################
# vecorized operations on sequences
#############################

# enable computations to happen in parallel

x <- 1:4; y <- 6:9  # define two sequences

x+y  # add nth element of x to nth element of y
x >= 2  # compare each value and return a logical vector

# works for any comparison or arithmetic operator

#############################
# vecorized operations on matrices
#############################

x <- matrix(1:4,2,2); y <- matrix(rep(10,4),2,2)
x; y    # display both (two commands on one line)
x*y     # element-wise multiplication
x %*% y # true matrix multiplication
