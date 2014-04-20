#############################
# Class:      https://class.coursera.org/rprog-002
# Assignment: Programming Assignment 3 - Part 4
# Student:    Jeanne-Anne Jensen, jana.jensen@comcast.net
#############################

rankall <- function(outcome,  # "heart attack", "heart failure", or "pneumonia"
                    num = "best" # "best" (default), "worst", or an integer indicating the ranking
                    ) {
    
    # initialize global variable(s)
    colidx <- integer()  # index for which column we will report data result for
    descend <- FALSE     # sort defaults to increasing
    
    
    ############
    ## Read outcome data
    ############
    datadir <- "~/GitHub/datasciencecoursera/ProgAssignment3-data"
    filename <- "outcome-of-care-measures.csv"
    fullfilename <- paste(datadir,filename,sep="/")
    data <- read.csv(fullfilename, colClasses = "character")
    
    ############
    ## Check that outcome is valid
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
    
    ############
    ## For each state, find the hospital of the given rank
    ############

    # get hospitals, states, and outcomes split by state
    subData <- data[,c(2,7,colidx)]  # just use the columns we want
    names(subData) <- c("hospital","state","value") # rename columns for convenience
    subData[,3] <- suppressWarnings(as.numeric(subData[,3]))  # convert values to numbers
    stateData <- split(subData,data$State) # split into separate lists by state
    
    # handle "best"/"worst"
    if(num=="best")  num <- 1                   # best is listed first
    if(num=="worst") {
        num <- 1
        descend <- TRUE  # worst is first if descending
    }

    # order each state by value (omit missing), then alphabetically by name
    ordData <- lapply(stateData, function(x){
        x[order(x$value,x$hospital,    # sort by value then name
                na.last=NA,            # omit missing values
                decreasing=descend),]  # decrease if "worst", otherwise increase
        })
    
    
    # create a data frame of the names and state for hospitals of the selected rank
    df <- do.call("rbind", lapply(ordData, function(x) x[num,c(1,2)]))
    
    # when the state doesn't have any hospitals of the selected rank, both
    # hospital and state reflect NA. Replace missing state with state name
    # using the same index
    df$state[is.na(df$state)] <- names(stateData)[is.na(df$state)]
        
    ############
    ## Return a data frame with the hospital names and the state for the
    ## selected rank
    ############
    df
}