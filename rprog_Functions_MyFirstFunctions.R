#############################
# First function
#############################
add2 <- function(x,y) {
    x + y
}
add2(2,3)

#############################
# Do something a little more interesting
#############################
above10 <- function(x) {  # assumes x is a numeric vector
    use <- x > 10  # return logical vector indicating which values are >10
    x[use]         # subset x with the logical vector
}
v <- 1:15   # create a vector
above10(v)  # test the function

#############################
# Make more dynamic
#############################
aboveN <- function(x,n) {
    use <- x > n
    x[use]
} 
v <- 1:15   # create a vector
above(v)  # test the function, should error missing n
above(v,9) # test with both args

#############################
# Add a default
#############################
above10orN <- function(x,n=10) { # default n to 10
    use <- x > n
    x[use]
} 
v <- 1:15   # create a vector
above10orN(v)   # test, returns above 10
above10orN(v,9) # test, returns above 9

#############################
# Mean of each column
#############################
columnMean <- function(data) {
    nc <- ncol(data)
    means <- numeric(nc) # create empty vector w/length matching number of cols
    
    for(i in 1:nc) {
        means[i] <- mean(data[,i]) # fill ith element w/the mean of that column
    }
    
    means   # last expression means this is what gets returned
}
columnMean(airquality) # test

#############################
# enhance to handle NA
#############################
columnMeanNA <- function(data, removeNA=TRUE) {
    nc <- ncol(data)
    means <- numeric(nc) # create empty vector w/length matching number of cols
    
    for(i in 1:nc) {
        means[i] <- mean(data[,i], na.rm=removeNA) # use the new parameter
    }
    
    means   # last expression means this is what gets returned
}
columnMeanNA(airquality) # test with NA removed by default
columnMeanNA(airquality, removeNA=FALSE) # test with NA not removed
