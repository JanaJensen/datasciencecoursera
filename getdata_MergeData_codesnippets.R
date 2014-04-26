#############################
# getting data from dropbox
#############################
setwd("C:\\Users\\Skukkuk\\Desktop\\Class - Data Science")
if(!file.exists("data")){dir.create("data")}
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1,destfile="./data/reviews-apr29.csv")
download.file(fileUrl2,destfile="./data/solutions-apr29.csv")
list.files("./data")
##
reviews <- read.csv("./data/reviews-apr29.csv")
head(reviews,2)
names(reviews)
##
solutions <- read.csv("./data/solutions-apr29.csv")
head(solutions,2)
names(solutions)


#############################
# merge data
#############################
#join reviews.solution_id to solutions.id
mergedData <- merge(reviews,            # x
                    solutions,          # y
                    by.x="solution_id", # field in x
                    by.y="id",          # field in y
                    all=TRUE)           # outer join
head(mergedData)
names(mergedData)  # note that common names specify source

# merge defaults to joining by all common column names
# in this example, these four fields would all be (incorrectly) joined:
intersect(names(reviews),names(solutions))

mergedDataWrong <- merge(reviews,solutions,all=TRUE)
head(mergedDataWrong)


#############################
# plyr join
#############################
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df1;df2
arrange(join(df1,df2),id)  # needs a common join field name

#####
# multiple data frames
#####
library(plyr)
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList <- list(df1,df2,df3)
join_all(dfList)  # nice and easy if they all have a common id
