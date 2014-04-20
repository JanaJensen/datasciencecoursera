#############################
# Knowing there's a problem
#############################

########
# Indications:
#  - message: generic notification, execution continues, message @ end
#  - warning: something unexpected, execution continues, message @ end
#  - error: fatal problem, message @ occurance
#  - condition: generic concept for something unexpected
########

# generate a warning:
log(-1)  # get NaN w/warning, can continue on

# create a function
printmessage <- function(x){
    if(x>0)
        print("x is greater than zero")
    else
        print("x is less than or equal to zero")
    invisible(x) # prevent auto-printing, returns w/o display??
}
# normal use
printmessage(40)
# generate an error
printmessage(NA)

# revise to fix that problem
printmessage2 <- function(x){
    if(is.na(x))
        print("x is a missing value!")
    else if(x>0)
        print("x is greater than zero")
    else
        print("x is less than or equal to zero")
    invisible(x) # prevent auto-printing, returns w/o display??
}
# normal use
printmessage2(40)
# now no error
printmessage2(NA)
# see in use
x <- log(-1)   # NaN
printmessage2(x)  # get missing value message
# generate a bad result
printmessage2("blah")  # get "x is greater than zero"

########
# How do you know something's wrong?
#  - What was your input? How did you call the function?
#  - What were you expecting? Output? Messages? Something else?
#  - What did you get?
#  - How does what you got differ from what you expected?
#  - Were your expectations correct in the first place?
#  - Can you reproduce the problem (exactly)? How?
########

#############################
# Debugging tools in R
#############################

# traceback - print out function call stack after an error (chain of functions)
# debug - flags a function so you can step through it one line at a time
# browser - suspends function exectution and goes into debug mode when called
# trace - allows insertion of debugging code in specific places
# recover - allows mod of error behavior so you can brows function call stack
# print/cat statements - if you must

#############################
# traceback
#############################

# generate an error for an unassigned var
mean(xx)
# immediately run traceback to see how you got there
traceback()
# find error occured in top level function

# slightly more interesting example
lm(y-x) # non-existent variables
traceback()
# see multiple levels of function calls

#############################
# debug
#############################

debug(lm)  # flag lm function for debug
lm(y-x)
# see entire code of function then in Browse mode
# Browsing in function's environment
#n<enter> to go to next line, repeat until you get the error
# debug can be nested

#############################
# recover
#############################

options(error=recover) # set global option until restart R
read.csv("nosuchfile") # get an error with menu of function call stack
# read.csv called read.table
# read.table called file
# file got the error
# choose a number to explore the environment and traceback
