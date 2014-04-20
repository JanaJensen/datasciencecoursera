#############################
# Installing RMySQL on Windows
#############################

###################
# Attempt 1
###################
# do a bunch of complicated install stuff for RTools and MySQL
# so that you can use RMySQL
# per instructions at http://biostat.mc.vanderbilt.edu/wiki/Main/RMySQL
#install.packages('RMySQL',type='source') # one time
#library("RMySQL")   # doesn't work.

###################
# Attempt 2
###################
# instructions at https://class.coursera.org/getdata-002/forum/thread?thread_id=246
##########
# A) Update R to version 3.1.0 (2014-04-10) using the installr package
##########
# update instructions from http://www.r-statistics.com/2013/03/updating-r-from-r-on-windows-using-the-installr-package/
# updates from R-3.0.3 to R-3.1.0

# installing/loading the package:
if(!require(installr)) { 
    install.packages("installr"); require(installr)} #load / install+load installr

# using the package:
updateR() # this will start the updating process of your R installation.
          # It will check for newer versions, and if one is available, will
          # guide you through the decisions you'd need to make.

##########
# B) Update RStudio to version Version 0.98.501
##########
# already on 0.98.501, just close and reopen app to start newer R version

##########
# C) Download and install RTools 3.1 
##########
# I think I did that in Attempt 1

##########
# D) Downloaded MySQL installer
##########
# I did that in Attempt 1

##########
# E) Configured the environment variables
##########
# instructions at http://www.ahschulz.de/2013/07/23/installing-rmysql-under-windows/
# steps 1 & 2 done in Attempt 1
# 3. Tell Windows where the MySQL-Libraries are
#   - set environment variable MYSQL_HOME to C:\Program Files\MySQL\MySQL Server 5.6
# 4. Compiling
#   - restart R
install.packages("RMySQL", type = "source")  # still not working

##########
# F) I created a file called Renviron.site
##########
# location: C:\Program Files\R\R-3.1.0\etc
# content: MYSQL_HOME=C:/PROGRA~1/MySQL/MYSQLS~1.6
# restart R
install.packages("RMySQL", type = "source")  # got further, but still not successful

##########
# G) Locate the file libmysql.dll
##########
# *COPY* from c:\Program Files\MySQL\MySQL Server 5.6\lib\
#          to c:\Program Files\MySQL\MySQL Server 5.6\bin\
# and, because 32-bit machine,...
# create folder c:\Program Files\MySQL\MySQL Server 5.6\lib\opt
# *COPY* libmysql.lib
#        from c:\Program Files\MySQL\MySQL Server 5.6\lib
#          to c:\Program Files\MySQL\MySQL Server 5.6\lib\opt

##########
# H) Restart RStudio
##########
# (Warning: some people have suggested that rebooting your machine at this point,
# before may be helpful). Make sure that RStudio is using the same R version as
# your machine architecture (Luong The Vinh's suggested this).
# Go to Tools > Global Options, and if click on change if you need to.

# When RStudio starts, you can check the values of the environment variables
# using the function Sys.getenv(), as in this example:

envVariables = Sys.getenv()
envVariables["PATH"]
envVariables["MYSQL_HOME"]

##########
# I) In the RStudio console execute (fingers crossed):
##########
install.packages("RMySQL", type = "source")  # * DONE (RMySQL)!!!!!

##########
# final test
##########
library("RMySQL")

### OMG!! IT WORKS!!!