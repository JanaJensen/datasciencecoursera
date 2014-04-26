library(reshape2)
head(mtcars)  # example dataset in R


#############################
# normalize data with melt
#############################
# convert rownames to a data element
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, # data set
                id=c("carname","gear","cyl"), # keep these denormalized
                measure.vars=c("mpg","hp"))   # normalize these into rows
head(carMelt)  # "mpg" is now a value in "variable" column
tail(carMelt)  # ditto with "hp"


#############################
# casting data frames
#############################
cylData <- dcast(carMelt,   # input data
                 cyl         # one row per each value
                 ~ variable) # one col for each value ("mpg"/"hp")
cylData # distributions
cylData <- dcast(carMelt,   # input data
                 cyl         # one row per each value
                 ~ variable, # one col for each value
                 mean)       # how to aggregate
cylData

?dcast


#############################
# averaging values within a factor
#############################
head (InsectSprays)  # R example dataset
tapply(InsectSprays$count, # detail
       InsectSprays$spray, # factor
       sum)                # function to apply over factor
###
# another approach, "split/apply combine"
###
spIns <- split(InsectSprays$count,InsectSprays$spray) # split into list of vectors
spIns  # see the list
sprCount <- lapply(spIns,sum) # sum each vector
sprCount  # list of the results
unlist(sprCount)  # combine results into a single vetor
# shorthand for the last three steps
sapply(spIns,sum)
###
# annother approach w/plyr  (this didn't actually work?)
# per forum: ddply(dataframe, (colname1, colname2), function)
###
# install.packages("dplyr")
library(dplyr)
ddply(InsectSprays,(spray,count),sum)
# try again (still doesn't work)
spraySums <- ddply(InsectSprays,.(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums)
head(spraySums)
