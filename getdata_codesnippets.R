#############################
# getting data from the internet
#############################
setwd("C:\\Users\\Skukkuk\\Desktop\\Class - Data Science")
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv", method="curl")
list.files("./data")
# save the date
dateDownloaded <- date()
dateDownloaded

# if URL starts with http use download.file()
# if URL starts wtih https, may need to set method="curl"

#############################
# reading Excel files 
#############################
setwd("C:\\Users\\Skukkuk\\Desktop\\Class - Data Science")
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.xlsx", method="curl")
list.files("./data")
# save the date
dateDownloaded <- date()
dateDownloaded

#install.packages("xlsx")  # one time only
library(xlsx)

#read a subset of the data
colIdx <- 2:3
rowIdx <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,
                              colIndex=colIdx,rowIndex=rowIdx)
cameraDataSubset

# see also: write.xlsx

# XLConnect package has more options
# see also XLConnect vignette


#############################
# reading XML
#############################
# components:
#    - markup - labels that give the text structure
#    - content - actual text of the document
#
# tags correspond to general labels:
#   - start tags:  <section>
#   - end tags:    </section>
#   - empty tags:  <line-break />  # both start and end
#
# elements are specific examples of tags:
#   <Greeting> Hello, world </Greeting>
#
# attributes are components of the label:
#   <img src="jeff.jpg" alt="instructor"/>
#   <step number="3"> Connect A to B. </step>
#############################

#install.packages("XML")   # one time only
library(XML)

fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)  # wrapper element for entire doc
xmlName(rootNode)
names(rootNode)

#####
# access similar to lists
#####
rootNode[[1]]  # see first element
rootNode[[1]][[1]] # display first element of the first element
rootNode[[1]][["calories"]]  # display the calories value of the first element

#####
# programatically extract all the values
#####
xmlSApply(rootNode[[1]],xmlValue)  # extract a vector of named values from teh first element
str(xmlSApply(rootNode[[1]],xmlValue))

# XPath language useful for programming with XML (not R)
#  /node   - top level node
#  //node  - node at any level

#####
# get items on the menu and their prices
#####
xpathSApply(rootNode,"//name",xmlValue) # list all items
xpathSApply(rootNode,"//price",xmlValue) # list all prices

#####
# another example, manually view the source for the web site first
#####
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
# extract from the html list items with a particular class
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams  <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams


#############################
# reading JSON
#############################

#install.packages("jsonlite")   # one time only
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/JanaJensen/repos")
names(jsonData)  # all names in the doc
names(jsonData$owner) # what names within nested array
jsonData$owner$login  # one login per repo
jsonData$url  # list urls for all my repos

#####
# writing data frames to JSON
#####
myjson <- toJSON(iris,pretty=TRUE) # generate JSON w/nice formatting
cat(myjson)  # display the resulting JSON format

iris2 <- fromJSON(myjson)  # read back in the JSON we just created
head(iris2)  # see it in a data set


#############################
# reading from MySQL
#############################
library("RMySQL") 

# public database at http://genome.ucsc.edu/goldenPath/help/mysql.html
# mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A
ucscDb <- dbConnect(MySQL(),user="genome",
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;")
dbDisconnect(ucscDb)  # be nice
result  # lists all databases available

#####
# focus in on one schema, hg19, particular build of the human genome
#####
hg19 <- dbConnect(MySQL(),user="genome",db="hg19",
                  host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)  # see there are 10,975 tables
allTables[1:5]     # list first 5

#####
# focus in on one table
#####
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
# count(*) = 58463

#####
# fetch entire table into a data frame
#####
affyData <- dbReadTable(hg19,"affyU133Plus2")
str(affyData)
head(affyData)

#####
# fetch part of a table
#####
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
# bring back just first 10 rows
affyMisSmall <- fetch(query,n=10)
# clear the query at remote server (to get out of Responding status)
dbClearResult(query)

dim(affyMisSmall)  # see 10 rows, 22 cols
str(affyMisSmall)

#####
# now that we have all the data we want, close the connection to the database
#####
dbDisconnect(hg19)  # be nice

# only select from public databases
# do joins locally


#############################
# reading from HDF5
#############################
#source("http://bioconductor.org/biocLite.R")
#biocLite("rhdf5")  # one time install
library(rhdf5)
created=h5createFile("example.h5")  # create a file
created

#####
# create groups
#####
created = h5createGroup("example.h5","foo")  # create group w/in file
created = h5createGroup("example.h5","baa")  # create group
created = h5createGroup("example.h5","foo/foobaa")  # create subgroup group
h5ls("example.h5")  # see group structure

#####
# write to groups
#####
A=matrix(1:10,nr=5,nc=2)  # shorthand
h5write(A,"example.h5","foo/A")
B=array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")  # see objects within groups

#####
# write a data set
#####
df = data.frame(1L:5L,seq(0,1,length.out=5),
                c("ab","cde","fghi","a","s"),
                stringAsFactors=FALSE)
h5write(df,"example.h5","df")
h5ls("example.h5")

#####
# reading data
#####
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf = h5read("example.h5","df")
readA

#####
# writing and reading chunks
#####
# replace the first three values in the first column
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A") # see how it has changed
# read just rows 3-5, column 1
h5read("example.h5","foo/A",index=list(3:5,1))


#############################
# reading from the web
#############################
# webscraping from HTML (see: http://en.wikipedia.org/wiki/Web_scraping)
#  - may be agains the terms of service for a site
#  - reading too many pages too quickly can get your IP blocked
con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode <- readLines(con)
close(con)  # be nice
htmlCode  # one long string

#####
# parsing with XML instead
#####
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=TRUE)
xpathSApply(html,"//title",xmlValue)  # see just the title node
xpathSApply(html,"//td[@id='col-citedby']",xmlValue)  # see number of times each was cited

#####
# using GET from httr package instead
#####
library(httr)
html2 <- GET(url)  # same url from before
content2 <- content(html2,as="text") # extract content from page
parsedHtml <- htmlParse(content2,asText=TRUE) # parse it out, like XML
xpathSApply(parsedHtml,"//title",xmlValue)  # see just the title node

#####
# accessing websites with passwords
#####
#this is why we use GET
pg1 <- GET("http://httpbin.org/basic-auth/user/passwd")
pg1  # see that we didn't get content because we didn't log in
# try again with authentication
pg2 <- GET("http://httpbin.org/basic-auth/user/passwd",
           authenticate("user","passwd")) # test website, not really secure
pg2  # see that we were authenticated
names(pg2)  # and we can access content
content2 <- content(pg2,as="text")  # retrieve content
parsed2 <- htmlParse(content2,asText=TRUE) # parse it out
parsed2  # not much there, just a test site

#####
# using handles
#####
# can save authentication across related pages
# (via cookies)
google <- handle("http://google.com")
pg1 <- GET(handle=google,path="/")  # doesn't need auth, but shows related
pg2 <- GET(handle=google,path="search")


#############################
# reading APIs
#############################

#####
# Twitter
#####
# 1. log in at https://dev.twitter.com/
# 2. go to https://dev.twitter.com/apps
# 3. <Create a New App>
# 4. register your app for later authentication
#        Name: datasciencecourseraJYJ
#        Descr: Course work for Coursera Data Science Specialization
#        Website: https://class.coursera.org/getdata-002
# 5. get info from API Keys tab
# 6. create an access token (also on API Keys tab)
# 7. create file with keys outside public GitHub
#        filename: twitter_keys.R
#        path: C:\Users\Skukkuk\Desktop\Class - Data Science
#        content:
#           Tkey          <- "<copied from webpage>"
#           Tsecret       <- "<copied from webpage>"
#           Ttoken        <- "<copied from webpage>"
#           Ttoken_secret <- "<copied from webpage>"
library(httr)
source("C:\\Users\\Skukkuk\\Desktop\\Class - Data Science\\twitter_keys.R")
myapp <- oauth_app("twitter",key=Tkey,secret=Tsecret)
sig <- sign_oauth1.0(myapp,token=Ttoken,token_secret=Ttoken_secret)
homeTL=GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)
homeTL  # see the resulting data

# continue Reading From APIs at 02:18
