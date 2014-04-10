#############################
# Syntax notes
#############################
# [  always returns object of same type as the original
# [[ extracts element of list or data frame by index or name with whatever type the element is
# $  extracts element of list or data frame by name with whatever type the element is

#############################
# Subsetting vectors
#############################

x <- c("a","b","c","c","d","a")
x[1]     # returns "a"
x[2]     # returns "a"
x[1:4]   # returns the first four elements
x[x > "a"]
u <- x > "a" # create logical vector
u   # print the true/falses
x[u]  # print the elements of x that have true in u

#############################
# Subsetting matrices
#############################

x <- matrix(1:6,2,3)
x
x[1,2] # returns content of one cell
x[2,1]
x[1,]  # returns whole row
x[,2]  # returns whole column

# by default, a cell/row/column in a matrix is extracted as a vector
# rather than a matrix. To get a matrix, set drop=false
# (drop drops the matrix dimension)
x <- matrix(1:6,2,3)
x
x[1,2]             # returns vector
x[1,2, drop=FALSE] # returns 1x1 matrix
x[1,]              # returns vector
x[1,,drop=FALSE]   # returns 1x3 matrix

#############################
# Subsetting lists
#############################

x <- list(foo=1:4,bar=0.6)
x[1]          # returns list with one element because x is a list
class(x[1])   # see? list.
x[[1]]        # returns the integer sequence
class(x[[1]]) # see? integer.
x$bar         # returns the numeric element
class(x$bar)  # numeric
x["bar"]      # reference by name
class(x["bar"])  # shows list

# to extract multiple elements, must use [ and return lists
x <- list(foo=1:4,bar=0.6,baz="hello")
x[c(1,3)]  # return first and third elements and get two lists
class(x[c(1,3)])

x <- list(foo=1:4,bar=0.6,baz="hello")
name <- "foo"  # create a new variable
x[[name]]      # using variable doesn't use quotes
x$name         # variable doesn't get dereferenced, no column "name", so no index, so no result
x$foo          # no quotes here anyway
x[["foo"]]     # using quotes means it loos for that name in the list

x <- list(a=list(10,12,14),b=c(3.14,2.81))
x[[c(1,3)]]   # extracts third element of first element recursively, i.e. 14
x[[1]][[3]]   # explicitly extracts first element then extracts third element
x[[c(2,1)]]   # extracts first element of second element

# partial matching is allowed with [[ and $
# partial match by default with $, not default in [[
x <- list(aardvark=1:5,apple=20)
x$a    # more than one matches, doesn't know which, returns NULL
x <- list(aardvark=1:5,baker=20)
x$a    # only one element starts with a so it knows which you want and returns aardvark's sequence
x[["a"]]  # in this case, it assumes the literal string, there is no a, returns null
x[["a",exact=FALSE]]  # now it knows to look for partial

#############################
# Removing NA (missing) values
#############################

x <- c(1,2,NA,4,NA,5)
bad <- is.na(x)  # set a logical variable testing
bad      # see the logical sequence
x[!bad]  # omit matches with bad
x[!is.na(x)]  # does the same without a variable, readibility issue

x <- c(1,2,NA,4,NA,5)
y <- c("a","b",NA,"d",NA,"f")
good <- complete.cases(x,y) # both have NA in the same places so 
good
x[good]
y[good]
y <- c("a",NA,"b","d",NA,"f")
good <- complete.cases(x,y) # returns FALSE where either has NA
good
x[good]
y[good]

# airquality is a sample data fame included in R
airquality[1:6,] # see first six rows
good <- complete.cases(airquality)  # complete.cases omits rows with partial data
airquality[good,][1:6,]  # see that rows 5 and 6 are no longer present
