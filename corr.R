#############################
# Class:      https://class.coursera.org/rprog-002
# Assignment: Programming Assignment 1 - Part 3
# Student:    Jeanne-Anne Jensen, jana.jensen@comcast.net
#############################

corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations.If no monitors meet the
    ## threshold requirement, then the function should return a numeric
    ## vector of length 0.
    
    
    # set global variables
    corv <- numeric()  # initialized return vector of length zero
    basedir <- "~/GitHub/datasciencecoursera"
    datadir <- paste(basedir,directory,sep="/")
    filenames <- list.files(datadir)
    
    # collect data from files
    for(i in seq_along(filenames)) {  # loop through files in the selected dir
        
        # set loop variables
        fullfilename <- paste(basedir,directory,filenames[i],sep="/")
        rawdata<- read.csv(fullfilename)
        goodidx <- complete.cases(rawdata)
        nobs <- sum(goodidx)   # TRUE = 1, so can simply sum
 
        if(nobs > threshold) {  # if complete obs meets threshold, add to vector
            goodsulf <- rawdata[goodidx,"sulfate"] # sulfate vector
            goodnitr <- rawdata[goodidx,"nitrate"] # nitrate vector
            corv <- c(corv,cor(goodsulf,goodnitr))
        } else {  # didn't meet the threshold
            next  # don't do anything with this monitor/file
        }
        
    }
    
    # return the vector
    corv
    
}