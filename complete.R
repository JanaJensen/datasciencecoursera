#############################
# Class:      https://class.coursera.org/rprog-002
# Assignment: Programming Assignment 1 - Part 2
# Student:    Jeanne-Anne Jensen, jana.jensen@comcast.net
#############################

complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
    
    # set global variables
    basedir <- "~/GitHub/datasciencecoursera"

    # collect data from monitors
    for(i in seq_along(id)) {  # loop through the selected monitors
        
        # set loop variables
        filename <- sprintf("%03d.csv", id[i])
        fullfilename <- paste(basedir,directory,filename,sep="/")
        rawdata <- read.csv(fullfilename)
        nobs <- sum(complete.cases(rawdata))   # TRUE = 1, so can simply sum
        
        if(i==1) {  # first iteration, initialize data frame
            df <- data.frame(id=id[i],nobs)
        } else {   # all other iterations, append to data frame
            df <- rbind(df,data.frame(id=id[i],nobs))
        }
    }
    
    # return the data frame
    df
    
}