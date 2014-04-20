#############################
# using data.table (more efficient than frame)
#############################

# inherits from data.frame
# written in C, so much faster

#install.packages("data.table")   # one time only
library(data.table)

# this part of syntax is similar to data.frame
set.seed(30)
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
set.seed(30)
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
DF
DT

# what data tables are in memory?
tables()  # rows, size, columns, key

# subsetting similar to data frame
DF[2,]  # get row 2, notice index is 2 - global
DT[2,]  # get row 2, notice index is 1 - local
DT[DT$y=="a"]  # get rows where y="a"

# differences from data frame
DF[c(2,3)]    # returns columns 2-3
DT[c(2,3)]    # returns rows 2-3

DF[,c(2,3)]   # still returns columns 2-3
DT[,c(2,3)]   # completely different

# For data.table, the arg after a comma is an "expression"
# In R, an expression is a collection of statements in curly brackets
#   so they get processed together

# So you can pass a list of functions to be performed
DT[,list(mean(x),sum(z))]  # returns just the results
DT[,table(y)]  # returns a table of y values

# add new column
DT[,w:=z^2]  # add col w as z squared
DT
tables()  # still only the one table in memory

# WARNING!!! copies don't work as expected
DT2 <- DT # now a second copy is made, but not really
DT[,y:=2]  # change y to always be 2 in the original
DT    # y always 2
DT2   # y always 2 here, too; have to use copy function instead

# multi-step operations
DT[,m:={tmp <- (x+z); log2(tmp+5)}] # create new variable in two steps, last stmt is returned
DT

# plyr-like operations
DT[,a:=x>0]  # create new binary variable
DT[,b:=mean(x+w),by=a]  # b is a repeating value with the mean for group a
DT

# special variables
set.seed(123)
DT <- data.table(x=sample(letters[1:3],1E5,TRUE))
DT
DT[,.N,by=x]  # count the number of occurances of x

#############################
# Keys
#############################
DT <- data.table(x=rep(c("a","b","c"),each=100),y=rnorm(300))
DT
setkey(DT,x)
DT['a']  # can subset by key value

#############################
# Joins
#############################
DT1 <- data.table(x=c('a','a','b','dt1'),y=1:4)
DT2 <- data.table(x=c('a','b','dt2'),z=5:7)
DT1
DT2
setkey(DT1,x); setkey(DT2,x)  # set a common join key
merge(DT1,DT2)  # dt1 and dt2 values doen't appear because its an inner join

#############################
# Fast reading
#############################
big_df <- data.frame(x=rnorm(1E6),y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file,
            row.names=FALSE,col.names=TRUE,  # no row/col names
            sep="\t",      # tab delimited
            quote=FALSE)   # don't quote strings
# compare read times...
system.time(fread(file))
system.time(read.table(file, header=TRUE, sep="\t"))
# ...and see that fread is much, much faster
