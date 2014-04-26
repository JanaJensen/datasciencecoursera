#############################
# getting data from the web
#############################
setwd("C:\\Users\\Skukkuk\\Desktop\\Class - Data Science")
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv")
list.files("./data")
restData <- read.csv("./data/restaurants.csv")

#############################
# creating variables
#############################

#####
# creating sequences, e.g. if you need an index for a data set
#####
s1 <- seq(1,     # start at 1
          10,    # end at 10
          by=2)  # increment by 2
s1
s2 <- seq(1,        # start at 1
          10,       # end at 10
          length=3) # create 3 values, distrib values evenly
s2
x <- c(1,3,8,25,100);  # explicitly list values in a vector
seq(along = x)         # index 1 per value in x

#####
# add a flag column
#####
restData$nearMe <- restData$neighborhood %in% c("Roland Park","Homeland")
str(restData)  # see new field
table(restData$nearMe)   # see distribution of values

#####
# create binary variables
#####
restData$zipWrong <- ifelse(restData$zipCode<0,TRUE,FALSE)
table(restData$zipWrong,restData$zipCode<0) # verify new data

#####
# create categorical variables
#####
restData$zipGroups <- cut(restData$zipCode,breaks=quantile(restData$zipCode))  # break them into roughly equal quantiles
table(restData$zipGroups)  # see distribution of values
table(restData$zipCode,restData$zipGroups)  # verify they went into the right groups
# easier cutting
#install.packages("Hmisc")
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode,
                           g=4)  # break into 4 equal groups
str(restData)  # see that new group created as a factor
table(restData$zipGroups)  # prettier headers, too
table(restData$zipCode,restData$zipGroups)  # verify they went into the right groups

#####
# create factor variables
#####
restData$zcf <- factor(restData$zipCode) # turn into facto, zip is not a value for calc
restData$zcf[1:10]
str(restData$zcf)

# exploring factor variables
yesno <- sample(c("yes","no"),size=10,replace=TRUE)
str(yesno)  # character vector
yesno
yesnofac <- factor(yesno,levels=c("yes","no"))
relevel(yesnofac,ref="yes")   # make yes index 1, no index 2
as.numeric(yesnofac)

#####
# mutate function creates new version of a variable and adds to data set
#####
library(Hmisc); library(plyr)
restData2 <- mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups) 

#############################
# common transormations
#############################
# abs(x)
# sqrt(x)
# ceiling(x)
# floor(x)
# round(x,digits=n)
# signif(x,digits=n)
# cos(x), sin(x), etc.
# log(x), log2(x), log10(x)
# exp(x)