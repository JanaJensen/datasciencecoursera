#############################
# Date/time types
#############################

# dates are stored internally as the number of days since 1970-01-01
x <- as.Date("1970-01-01")
class(x)
x   # implicit print method formats "YYYY-MM-DD"
unclass(x)   # prints the underlying stored number
unclass(as.Date("1970-01-02")) # 1 day after 1970-01-01
unclass(as.Date("1969-12-31")) # 1 day before 1970-01-01

# times are stored internally as the number of seconds since 1970-01-01
# POSIXct is a large integer under the hood, useful for storing in data frames
# POSIXlt is a list underneath with common attributes

# weekdays  - give day of week for either day or time
# months    - give name of month for either day or time
# quarters  - give Q# for either day or time

x <- Sys.time()  # now
x   # implicit print method formats "YYYY-MM-DD HH:MI:SS TZ"
class(x)   # already in POSIXct
unclass(x) # see the number of seconds since 1970-01-01
x$sec  # get an error because ct doesn't have list elements

p <- as.POSIXlt(x)  # cast as lt
names(unclass(p))  # see the elements you can reference
p$sec  # extract the seconds from the time

#############################
# Conversion from strings
#############################
datestring <- c("January 10, 2012 10:40", "December 9, 2011")
class(datestring)
x <- strptime(datestring,"%B %d, %Y %H:%M") # convert to time objects
x  # Dec date doesn't have all format elements, so get NA
class(x)

?strptime  # check date format strings

#############################
# Date/time operations
#############################
x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
x-y  # can't do operations on mix of classes
class(x); class(y)
x <- as.POSIXlt(x)  # convert x to compatible type
x-y  # now can take difference

# tracks leap years (and leap seconds)
x <- as.Date("2012-03-01"); y <- as.Date("2012-02-28")  # leap year
x-y   # 2 days difference
x <- as.Date("2011-03-01"); y <- as.Date("2011-02-28")  # non-leap year
x-y   # 1 day difference

# tracks time zone
x <- as.POSIXct("2012-10-25 01:00:00")
y <- as.POSIXct("2012-10-25 01:00:00", tz = "GMT")
y-x   # -7 hours for PDT
