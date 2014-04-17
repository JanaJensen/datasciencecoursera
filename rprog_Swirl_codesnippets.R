#############################
# Experimental feature in R
# - Statistics with Interactive R Learning (SWIRL)
#############################

install.packages("swirl")  # Installs swirl
library(swirl)             # Loads swirl
swirl()                    # Runs swirl

# some things I didn't already know . . 

#############################
# Sequences of numbers
#############################

seq(1,20)  # same as 1:20
seq(0,10, by=0.5)  # increments by 0.5
my_seq <- seq(5,10,length=30) # generate a sequence of 30 numbers between 5 and 10
length(my_seq)   # see? 30

seq(along = my_seq) # generates the index for my_seq
seq_along(my_seq)   # we had this before, but repetition is good

rep(0, times=40)    # replicate zero 40 times
rep(c(0,1,2), times=10)  # collates the sequence over and over 
rep(c(0,1,2), each=10)   # batches 10 copies of zero, then 10 of 1, etc.

#############################
# Logical expressions
#############################
A <- TRUE; B <- FALSE
A | B   # union/logical or
A & B   # intersection/logical and
!A      # not A

#############################
# String operators
#############################
my_char <- c("My","name","is")
paste(my_char,collapse=" ")
my_name <- c(my_char,"Jana")
paste(my_name,collapse=" ")

paste("Hello","world!", sep=" ")

paste(1:3,c("X", "Y", "Z"), sep="")  # element-wise combo

#############################
# Creating dummy data with NA
#############################
y <- rnorm(1000)   # 1000 random numbers
z <- rep(NA,1000)  # 1000 missing values
myData <- sample(c(y,z),100)  # randomly choose 100 elements from the combined
                              #    bucket of y and z
myNA <- is.na(myData)  # where are the missing values
myNA  # TRUE=1; FALSE=0
sum(myNA)  # TRUE=1 and FALSE=0, so sum give total number of NA

myData[!is.na(myData) & myData > 0]  # returns all non-missing positive elements

myData[c(3,5,7)]  # return three specific elements

myData[c(-3,-5,-7)]  # return everything except three specific elements
myData[-c(3,5,7)]    # same result

