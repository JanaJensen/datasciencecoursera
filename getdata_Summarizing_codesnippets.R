#############################
# getting data from the web
#############################
setwd("C:\\Users\\Skukkuk\\Desktop\\Class - Data Science")
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/restaurants.csv")
list.files("./data")
restData <- read.csv("./data/restaurants.csv")

head(restData,n=3)  # first 3 rows
tail(restData,n=3)  # last 3 rows
summary(restData)   # basic profile of each variable
str(restData)       # what structure is it assuming

# disply quantiles
quantile(restData$councilDistrict,
         na.rm=TRUE)  # omit nulls
quantile(restData$councilDistrict,
         probs=c(0.5,0.75,0.9))  # only show what's at these thresholds

# display table of value(s) and counts
table(restData$zipCode,
      useNA="ifany")  # add a col in table for NA
table(restData$councilDistrict,restData$zipCode)  # counts by 2-dims

######
# check for missing values
######
sum(is.na(restData$councilDistrict))  # count them
any(is.na(restData$councilDistrict))  # detect presence
all(restData$zipCode>0)               # do all values satisfy condition

# check all cols at once
colSums(is.na(restData))  # how many NA in each variable
all(colSums(is.na(restData))==0)  # do they all have no NA

######
# values with specific characteristics
######
table(restData$zipCode %in% c("21212"))  # count in one value
table(restData$zipCode %in% c("21212","21213"))  # count in two values

# get whole rows where value in list
restData[restData$zipCode %in% c("21212","21213"),]

######
# crosstabs
######
data(UCBAdmissions)   # use example within R
DF = as.data.frame(UCBAdmissions)
summary(DF)  # profile data
# generate a frequency count by Gender and Admit (where relationship exists)
xt <- xtabs(Freq ~ Gender + Admit,data=DF)
xt
xtabs( ~ Gender + Admit,data=DF)  # counts rather than sum

# break out by pivot pages
warpbreaks$replicate <- rep(1:9,len=54)  # another example with an extra column
xt = xtabs(breaks ~.,  # break out by all variables
           data=warpbreaks)
xt
# flatten the 3-dimensions
ftable(xt)

######
# size of a data set
######
fakeData = rnorm(1e5)
object.size(fakeData)  # report in bytes
print(object.size(fakeData),units="Mb")
