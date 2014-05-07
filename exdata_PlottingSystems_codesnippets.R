# warning! can't really use frunctions from one system within another

# key parameters common to all the systems:
#   pch: plotting symbol
#   lty: line type
#   lwd: line width
#   col: color
#   xlab: x-axis label
#   ylab: y-axis label

# par() function sets global graphics parameters
#   common arguments:
#      las: orientation of axis labels
#      bg:  background color
#      mar: margin size
#      oma: outer margin size
#      mfrow: number of plots per row,columns (filled row-wise)
#      mfcol: number of plots per row,columns (filled column-wise)
#
#   special calls to see current settings:
par("bg")
par("mar")
par("mfrow")

#############################
# base plotting system
#############################
#  - artist's palette model
#  - start with a blank canvas and start from there
#  - start with plot function
#  - use annotation functions to add/modify (text,lines,points,axis)
#
# example
library(graphics)
library(grDevices)

library(datasets)
data(cars)
with(cars,plot(speed,dist))

# initialize a plot one of three ways
hist(airquality$Ozone)  # histogram
with(airquality,plot(Wind,Ozone))  # scatter plot
boxplot(Ozone ~ as.factor(Month),airquality,xlab="Month",ylab="Ozone (ppb)")

# base functions:
#   plot: make scatter plot
#   lines:  add lines given 2 vectors (connect dots)
#   points: add points
#   text: add text labels using specified x,y coord
#   title: annotate axis labels, title, subtitle, outer margin
#   mtext: arbitrary text to inner or outer margins
#   axis: add ticks/labels

# base plot with annotation
with(airquality,plot(Wind,Ozone,main="Ozone and Wind in NYC"))
# highlight a subset of the points
with(subset(airquality,Month==5),points(Wind,Ozone,col="red"))

# initialize, but doesn't plot anything to start with
with(airquality,plot(Wind,Ozone,main="Ozone and Wind in NYC"),
     type="n")
# add subsets in various colors
with(subset(airquality,Month==5),points(Wind,Ozone,col="blue"))
with(subset(airquality,Month!=5),points(Wind,Ozone,col="red"))
# add legend
legend("topright",pch=1,col=c("blue","red"),legend=c("May","other months"))

# next example
with(airquality,plot(Wind,Ozone,main="Ozone and Wind in NYC",
                     pch=20))  # filled-in dots
model <- lm(Ozone ~ Wind, airquality) # best fit function
abline(model,lwd=2) # add to chart

# multiple base plots
par(mfrow = c(1,2))  # two plots, side-by-side
with(airquality,{
    plot(Wind,Ozone,main="Ozone and Wind")
    plot(Solar.R,Ozone,main="Ozone and Solar Radiation")
})

# another example
par(mfrow=c(1,3),   # three plots, side-by-side
    mar=c(4,4,2,1), # margins little bit smaller than default
    oma=c(0,0,2,0)) # outer margin (more space on top for master title)
with(airquality,{
    plot(Wind,Ozone,main="Ozone and Wind")
    plot(Solar.R,Ozone,main="Ozone and Solar Radiation")
    plot(Temp,Ozone,main="Ozone and Temperature")
    mtext("Ozone and Weather in NYC",outer=TRUE)
})

# make a striped band on the last plot
abline(h=75,lwd=20,col="blue")
abline(h=75,lwd=10,col="white")
abline(h=75,lwd=4,col="red")


#############################
# lattice system
#############################
#  - plots created with a single function call (xyplot,bwplot, etc)
#  - most useful for conditioning types of plots (how y changes with x across levels of z)
#  - good for coplots
#
# example
library(lattice)  # uses grid package, not used directly
state <- data.frame(state.x77, region=state.region)
xyplot(Life.Exp ~ Income | region, # plot LE over income by region
       data=state,     # data source
       layout=c(4,1))  # four columns, one row


#############################
# ggplot1 system
#############################
#  - between base and lattice
#  - auto-deals w/spacings, text, etc, but allows additions
#  - default good, but can customize
#
# example
# install.packages("ggplot2")
library(ggplot2)
data(mpg)
qplot(displ,hwy,data=mpg)
