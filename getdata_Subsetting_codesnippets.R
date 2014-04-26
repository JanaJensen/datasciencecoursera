#############################
# Subsetting and sorting
#############################
# set up random dummy data with nulls
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),];X$var2[c(1,3)] <- NA
X

# quick review of subsetting
X[,1]  # disply first column as a vector
X[,"var1"]  # display column named var1 as a vector
X[1:2,"var2"]  # display the first two rows of col named var2

# subset with logical ands/ors
X[(X$var1<=3 & X$var3>11),]  # rows where var1 lt/eq 3 and var3 gt 11
X[(X$var1<=3 | X$var3>11),]  # rows where var1 lt/eq 3 or var3 gt 11

# dealing with missing values
X[which(X$var2>8),]  # which looks for positive trues and omits NA

# sorting
sort(X$var1)                  # sort asc (omit NA)
sort(X$var1,decreasing=TRUE)  # sort desc
sort(X$var2,na.last=TRUE)     # sort asc w/NA last
sort(X$var2,na.last=FALSE)    # sort asc w/NA first

# order a data frame
X[order(X$var1),]  # display only, doesn't change storage
X[order(X$var1,X$var3),]  # multi-col sort

# orderint with plyr
library(plyr)
arrange(X,var1)        # sort asc (incl NA)
arrange(X,desc(var1))  # sort desc (incl NA)

# adding columns
X$var4 <- rnorm(5)  # add col named var4
X

# adding columns with cbind
Y <- cbind(X,rnorm(5))  # add unnamed column 
Y
# rbind adds rows
