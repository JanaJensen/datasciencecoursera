

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
tabAll <- read.table("datatabel.txt",colClasses=classes)  # apply that sequence to the full table

# telling R how many rows there are enables it to preallocate the right amount of memory


# resume part 1 video at 09:24
