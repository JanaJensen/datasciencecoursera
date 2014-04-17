#############################
# Syntax
#############################

# read.table    reads tabular data from text files into data frames
# read.csv      reads tabular data from text files into data frames
# readLines     reads text files line by line
# source        reads R code files (inverse of dump)
# dget          reads R code files (inverse of dput)
# load          reads in saved workspaces
# unserialize   reads single R objects in binary form

# write.table   writes tabular data into text files from data frames
# writeLines    writes text files line by line
# dump          writes R code files (inverse of source)
# dput          writes R code files (inverse of dget)
# save          writes in saved workspaces
# serialize     writes single R objects in binary form

# note that the default is R will figure out appropriate parameters
# and it's pretty good except the default separator is a space.
help(read.table)  # see syntax, arguments, etc.

# !!!!! get to know how much memory your computer has and about how
#       much data can be loaded into a data frame. Note that having
#       derive parameters takes more memory.

# quick and dirty way to derive data types, have R derive from first
# few rows and apply that to the entire file read.
initial <- read.table("datatable.txt",nrows=100) # read a small amount of data
classes <- sapply(initial,class) # generate a sequence of the derived classes
tabAll <- read.table("datatabel.txt",colClasses=classes) # apply seq to full set

#############################
# Know your system
#############################

# how much memory is availalble?
# What other apps are in use?
# What OS? 30-bit or 64-bit?

# telling R how many rows there are enables it to preallocate the right amount
#    of memory
# rows x # cols x size (8 B/numeric)
# bytes / 220 b/MB / 1000 MB/GB = GB
# compare to RAM

#############################
# Textual formats
#############################

# dump and dput preserve the metadata so no need for rediscovery later.
# Useful for files stored in version control.
# Editable. Corruption is easier to fix in text files
# Text formats adhere to "Unix philosophy"
# Text is not space-efficient.

#dget saves a single R object as the R code to generate it
y <- data.frame(a=1,b="a")
dput(y)   # displays the object stored as R code
dput(y, file="y.R")   # save to file
new.y <- dget("y.R")  # read the data back in
new.y

#dump can write multiple R objects as the R code to generate them
# writes a character vector with the names of objects
x <- "foo"
y <- data.frame(a=1,b="a")
dump(c("x","y"),file="data.R")
source("data.R")  # read the file into memory
y
x

#############################
# Interfaces outside the script
#############################

# file   opens a connection to a file
# gzfile opens a connection to a gzip file
# bzfile opens a connection to a bzip2 file
# url    opens a connection to a web page

str(file)  # display structure of the file function
# description is the file name
# open is a code for lock: "r", "w", "a", "rb" (binary), "wb", "ab"

# connections are useful when you want to read part of the file
con <- gzfile("words.gz")  # open connection to non-existent file
x <- readLines(con,10)     # read first 10 lines
x                          # display the 10 lines
close(con)                 # close the connection when done

# writeLines writes a character vector to a file
# each element of the vector becomes a line in the file

## this might take time
con <- url("http://www.jhsph.edu","r")
x <- readLines(con)
head(x)    # display first few lines
close(con)                 # close the connection when done
