#############################
# Function basics
#############################

# functions are "first class objects" and can be passed as arguments or nested
# return value is the last expression in the function body to be evalated
# "formal arguments" are included in the function definition

mydata <- rnorm(100)  # generate 100 random numbers with normal distribution

formals(sd)  # list formal arguments for sd function and defaults
sd(mydata)  # default call to standard deviation function
sd(x = mydata) # explicitly cite argument name
sd(x = mydata, na.rm=FALSE) # explicitly declare other arguments
sd(na.rm=FALSE, x=mydata)  # when explicitly named, args can be in any order
sd(na.rm=FALSE, mydata)  # unnamed args will be applied in order

args(lm)   # more compact way to list args and defaults

lm(data=mydata,  # named, gets applied to data
   y-x,          # positional, applied to first unused, formula
   model=FALSE,  # named, gets applied to model
   1:100)        # positional, applied to next unused, subset

lm(y-x,          # positional, applied to first unused, formula
   mydata,       # positional, applied to next unused, data
   1:100,        # positional, applied to next unused, subset
   model=FALSE)  # names, gets applied to model

# partial matching on argument names
# 1. check for exact match on named argument
# 2. check for unique partial match on named argument
# 3. check for positional match

#############################
# Defining a Function
#############################

f <- function(a,       # no default
              b=1,     # default
              c=2,     # default
              d=NULL)  # explicitly default to empty
{
    
}

# arguments are only evaluated when they are used (lazy)
# only get an error if you try to use one

f <- function(a,b) {
    print(a)
    print(b)
}
f(45)    # error only when be used because not specified
}

#############################
# "..." Argument
#############################

# ... indicates a variable number of arguments to be passed to other functions

myplot <- function(x,y,type='l',...) {   # changes one default type
    plot(x,y,type=type, ...)      # and passes the rest on
}

# ... can also be used in generic functions to pass extra arguments to methods

# ... also necessary when number of arguments cannot be known in advance
# examples where the first arguments are the set of R objects to be processed:
args(paste)
args(cat)

# any arguments listed after ... must be named explicitly and cannot be
#    partially matched
# example:
args(paste)
paste("a","b", sep=":") # paste together with : separator
paste("a","b", se=":")  # R pastes the : because it cannot know se refers to sep

