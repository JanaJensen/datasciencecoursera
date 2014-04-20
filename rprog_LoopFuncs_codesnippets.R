#############################
# Loop functions
#############################

# lapply - loop over list and eval function on each element
# sapply - same, but try to simplify result
# apply  - apply function over the margins of an array
# tapply - apply function over subsets of a vector
# mapply - multivariabe version of lapply

# split  - not a loop function, but used with them

#############################
# lapply
#############################

# lapply returns a list of results of the function applied a list
x <- list(a=1:5, b=rnorm(10))  # create a list numeric vectors
l <- lapply(x,mean)  # apply the mean function to each of the two list members
class(l)   # see that the result is a list
l          # of two scalar values w/the same names as the original vectors

# runif creates a vector of uniform random variables w/length of the param
runif(1)  # generate one random number
runif(2)  # generate two random numbers

# create a sequence of numbers
x <- 1:4
# pass to runif w/defaults using lapply which converts the sequence to a list
l <- lapply(x,runif)
class(l)  # still returns a list
l  # shows the list of vectors of random numbers between 0 and 1
# pass to runif w/specific parameters through lapply's ... parameter
l <- lapply(x,runif, min=0, max=10)
l  # now a list of vectors of random numbers between 0 and 10

# create a list of matrices
x <- list(a=matrix(1:4,2,2), b=matrix(1:6,3,2))
x
# apply a function on the fly by defining in lapply call
# to extract first column of each matrix (function does not persist,
# called an "anonymous function")
lapply(x, function(elt) elt[,1])

#############################
# sapply
#############################

# sapply tries to simplify the lapply result:
#   - if result is a list of elements all length 1, converts to a vector
#   - if result is a list of elements all same length, converts to matrix
#   - if it can't figure out a neat conversion, returns a list

x <- list(a=1:4,b=rnorm(10),c=rnorm(20,1),d=rnorm(100,5))
lapply(x,mean)  # see returns list of single numbers
sapply(x,mean)  # see returns numeric vector
mean(x)  # returns an error because mean works only on numeric vectors

#############################
# apply
#############################

# most often used to apply a function to the rows or columns of a matrix
# not faster than a loop, but all on one line
str(apply)  # see the syntax

x <- matrix(rnorm(200),20,10)  # create a random 20x10 matrix
x
apply(x,2,mean)  # caculate the mean of each column (dimension 2, [,10])
                 # , i.e. preserve the columns and collapse the rows
apply(x,1,sum)   # caculate the sum of reach row (dimension 1, [20,])
                 # , i.e. preserve the rows and collapse the columns

# highly optimized shortcuts
rowSums(x)   # same as apply(x,1,sum)
rowMeans(x)  # same as apply(x,1,mean)
colSums(x)   # same as apply(x,2,sum)
colMeans(x)  # same as apply(x,2,mean)

# another example
x <- matrix(rnorm(200),20,10)  # create a random matrix
# calculate 25th and 75th percentile for each row
apply(x,1,quantile,probs=c(0.25,0.75))  # returns 2x20 matrix of values

# average matrix in an array
a <- array(rnorm(2*2*10), c(2,2,10))   # create 3-dim array
# take average of all the 2x2 matrices within the array
# i.e. keep first two dimensions and collapse 3rd
apply(a,c(1,2),mean)  # average of 2x2 matrices is a 2x2 matrix
rowMeans(a,dims=2)    # shortcut with same result

#############################
# tapply
#############################

# splits a vector into pieces, applies a summary function to pieces, and puts
#    the pieces back together

str(tapply)
# INDEX is a factor or list of factors to classify subsets
# SIMPLIFY defaults to TRUE

# create vector of 10 normals, 10 uniforms, 10 normals w/a mean of 1 (30 total)
x <- c(rnorm(10),runif(10),rnorm(10,1))
x
f <- gl(3,10)  # create a list of 30 factors of 3 groups
f
tapply(x,f,mean) # take the mean of each factor group
tapply(x,f,mean,simplify=FALSE) # don't simplify and get list instead of vector
tapply(x,f,range)  # get min/max of values for each group

#############################
# split
#############################
# like tapply without the summary
str(split)  # splits vector into groups based on the factor

# create vector of 10 normals, 10 uniforms, 10 normals w/a mean of 1 (30 total)
x <- c(rnorm(10),runif(10),rnorm(10,1))
x
f <- gl(3,10)  # create a list of 30 factors of 3 groups
f

s <- split(x,f) split into a list of vectors
class(s)
s   # returns three vectors, one for each factor group
lapply(s,mean)  # take mean of each vector in the list

# another example
library(datasets) # load sample data frame
head(airquality)  # see first few rows
# calculate mean of Ozone, Solar.R, Wind, and Temp by Month
s <- split(airquality,airquality$Month)  # split by month
# apply annonymous function
lapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind","Temp")]))
# returns a list of 5 vectors of length 4

# simplify result to a matrix
sapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind","Temp")]))

# clean up the NAs
sapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind","Temp")],na.rm=TRUE))

#############################
# multi-level split
#############################

x <- rnorm(10)  # create a random vector
x
f1 <- gl(2,5)   # generate one random factor group
f1
f2 <- gl(5,2)   # generate a second factor group
f2
interaction(f1,f2) # product join between the two factor levels
str(split(x,list(f1,f2)))  # see that combining these gets the interaction
str(split(x,list(f1,f2),drop=TRUE))  # clear out the empty factor combinations

#############################
# mapply
#############################

# multivariate version of apply, i.e. multiple lists
str(mapply)
# FUN is the function to apply, must take at least as many args as the # lists

# an example of something tedious to type
list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))  # 4-1's, then 3-2's, etc.

# do the same thing shorter
mapply(rep,1:4,4:1)

#############################
# vectorizing a function that doesn't normally allow vector arguments
#############################

# define a function that generates noise
noise <- function(n,mean,sd){
    rnorm(n,mean,sd)
}
# normal use of the function
noise(5,1,2)  # get 5 values with mean of 1 and stddev of 2

# try to pass a vector of arguments:
noise(1:5,1:5,2) # get 5 values with mean of 5 and stddev of 2 (last pair)

# want 1 var w/mean of 1, 2 w/mean of 2, 3 w/mean of 3, etc.

# do it the direct way
list(noise(1,1,2),noise(2,2,2),noise(3,3,2),
     noise(4,4,2),noise(5,5,2))

# simpler approach
mapply(noise,1:5,1:5,2)
