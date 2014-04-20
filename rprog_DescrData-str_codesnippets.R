#############################
# str
#############################
str(0:10)  # describes the sequence
str(str)   # describes the function
str(lm)
str(ls)

x <- rnorm(100,2,4)  # numeric sequence
summary(x)           # see the basic range of the data
str(x)               # see the structure plus some sample data

x<- gl(40,10)  # factor list
summary(x)     # how many occurances of each factor
str(x)         # description of the structure

library(datasets)
head(airquality)     # first few rows
summary(airquality)  # basic range of each column
str(airquality)      # rowcount, column count, names of columns w/sample data for each

m <- matrix(rnorm(100),10,10)
str(m)     # tells the structure and first elements of first column
m[,1]      # see? first few values match str

s <- split(airquality,airquality$Month)  # create a list
str(s)   # description of each member of the list of data frames
