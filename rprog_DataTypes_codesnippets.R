#############################
# Assignment and display
#############################

# assign value 1 to variable x
x <- 1    # assignment expression
print(x)  # explicit print
x         # implicit print (auto-print)

# create character vector
msg <- "hello"
msg

#############################
# Vectors
#############################

# generate a sequence from 1 to 20
x <- 1:20
x

# create/concatenate a vector
# (each overwrites previous)
x <- c(0.4,0.6)     # numeric
x
x <- c(TRUE,FALSE)  # logical
x
x <- c(T,F)         # logical
x
x <- c("a","b","c") # character
x
x <- 9:29           # integer
x
x <- c(1+0i, 2+4i)  # complex
x
x <- c(1.7,"a")     # character, "1.7"
x
x <- c(TRUE,2)      # numeric, T=1,F=0
x

# create vector w/default initializatino
x <- vector("numeric",length=10)
x

# explicit casting, i.e. "coercion"
x <- 0:6
class(x)  # returns integer
as.numeric(x)   # prints the numeric
as.logical(x)   # prints translation, 0=F, all else=T
as.character(x) # prints translation
as.complex(x)

x <- c("a","b","c")
as.numeric(x)   # can't be translated

# matrices are vectors with dimension attribute
m <- matrix(nrow=2, ncol=3)
m      # see default to NA
dim(m) # tell dimensions of m
m <- matrix(1:6,nrow=2,ncol=3)
m  # see loaded by column

# creating a matrix from a vector
m <- 1:10
m
# convert to matrix by updating dim attribute
dim(m) <- c(2,5)
m

# creating a matrix by binding
x <- 1:3
y <- 10:12
cbind(x,y)  # bind these as columns
rbind(x,y)  # bind these as rows

# creating a list w/varying types
x <- list(1,"a",TRUE,1+4i)
x   # see indexed as vectors within list

#############################
# Factors
#############################

# factors are vectors of categories
# factors can be ordered (rank or HML) or unordered (MF)
# think of them as an integer vector with labels
x <- factor(c("yes","yes","no","yes","no"))
x   # see two levels, no and yes
table(x)    # generate a frequency count of each level
unclass(x)  # show underlying integers with labels separate

# set ordering with levels
x <- factor(c("yes","yes","no","yes","no")
            ,levels=c("yes","no"))
unclass(x)  # see that yes=1 now

#############################
# Missing values
#############################

# NaN = undefined mathematical operations
# NA = all missing values (including NAN)

x <- c(1,2,NA,10,3)
is.na(x)   # test for NA
is.nan(x)  # test for NAN

x <- c(1,2,NaN,NA,4)
is.na(x)   # test for NA
is.nan(x)  # test for NAN

#############################
# Data frames
#############################

# tabular data
# can have different classes in each column

x <- data.frame(foo=1:4,bar=c(T,T,F,F))
x
nrow(x)  # print number of rows
ncol(x)  # print number of columns

#############################
# Names
#############################

# sequence names
x <- 1:3
x
names(x)   # see no names
names(x) <- c("foo","bar","norf") # assign names to sequence
names(x)   # see names

# list names
x <- list(a=1,b=2,c=3) # create list with names
x
names(x)   # see names

# matrix names
m <- matrix(1:4, nrow=2,ncol=2)
dimnames(m) <- list(c("a","b"),c("c","d"))
m   # see names in matrix dimensions
