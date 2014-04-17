#############################
# Class:      https://class.coursera.org/rprog-002
# Assignment: Programming Assignment 1 - Part 1
# Student:    Jeanne-Anne Jensen, jana.jensen@comcast.net
#############################

pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    
    
    # set global variables
    basedir <- "~/GitHub/datasciencecoursera"
    
    # collect data from monitors
    for(i in seq_along(id)) {  # loop through the selected monitors
        
        # set loop variables
        filename <- sprintf("%03d.csv", id[i])
        fullfilename <- paste(basedir,directory,filename,sep="/")
        rawdata <- read.csv(fullfilename)[pollutant]
        
        if(i==1) {  # first iteration, initialize sequence
            gooddata <- rawdata[!is.na(rawdata)]
        } else {   # all other iterations, append to sequence
            gooddata <- c(gooddata,rawdata[!is.na(rawdata)])
        }
    }
    
    # return the mean to 3 digits
    round(mean(gooddata),digits=3)
}