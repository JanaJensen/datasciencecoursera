#############################
# Class:      https://class.coursera.org/rprog-002
# Assignment: Programming Assignment 3 - Part 2
# Student:    Jeanne-Anne Jensen, jana.jensen@comcast.net
#############################

best <- function(state,    # 2-char abbr
                 outcome   # "heart attack", "heart failure", or "pneumonia"
                 ) {

    # initialize global variable(s)
    colidx <- integer()  # index for which column we will report data result for
    
    ############
    ## Read outcome data
    ############
    datadir <- "~/GitHub/datasciencecoursera/ProgAssignment3-data"
    filename <- "outcome-of-care-measures.csv"
    fullfilename <- paste(datadir,filename,sep="/")
    data <- read.csv(fullfilename, colClasses = "character")
    
    ############
    ## Check that state and outcome are valid
    ############
    
    # check outcome against allowed values list and assign related colidx
    if(outcome=="heart attack"){
        # [11] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
        colidx <- 11
    } else if(outcome=="heart failure") {
        # [17] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
        colidx <- 17
    } else if(outcome=="pneumonia") {
        # [23] "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
        colidx <- 23
    } else {
        stop("invalid outcome")
    }

    # check state against values in the data
    if(!(state %in% data[,"State"])){
        stop("invalid state")
    }
    
    ############
    # excerpt and order just the columns of interest, omitting missing values
    ############
    
    stateData <- data[data$State==state,c(2,colidx)]  # get hospitals and outcomes for state
    names(stateData)  <- c("hospital","value")  # rename columns for convenience
    stateData[,2] <- suppressWarnings(as.numeric(stateData[,2]))  # convert values to numbers
    ordData <- stateData[order(stateData$value,stateData$hospital,na.last = NA),]
    
    ############
    ## Return hospital name in that state with lowest 30-day death rate
    ## (ties go alphabetically)
    ############
    ordData[1,1]  # return just the first hospital name
    
}