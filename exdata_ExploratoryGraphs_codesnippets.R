#############################
# Source: Tufte's "Beautiful Evidence"
#############################
#
# Principle 1: Show comparisons
#    - evidence is relative to another hypothesis or control (null hypothesis)
#    - e.g. asthma symptom free days w/air clearner vs not
#
# Principle 2: Show causality, mechanism, systematic structure
#    - what is your causal framework (model)
#    - e.g. symptom-free days compared to air particulate levels
#
# Principle 3: Show multivariate data
#    - escape flatland (more info on one chart)
#    - e.g seasonal plots side-by-side
#
# Principle 4: Integrate evidence
#    - integrate words, numbers, images, diagrams
#    - don't let the tool drive the analysis
#
# Principle 5: Describe & document presented evidence
#    - data graphic should tell a complete story that it is credible
#
# Principle 6: Content is king
#    - what story does the content tell?
#
#############################

#############################
# Why do we use graphs?
#############################
#  - to understand data properties
#  - to find patterns in data
#  - to suggest modeling strategies
#  - to debug analyses
#  - to communicate results
#
#####
# characteristics of exploratory graphs:
#####
#  - made quickly
#  - make a lot of them
#  - goal is personal understanding
#  - axes/legends are generally cleaned up later
#  - color/size primarily for information
#####
# see also R Graph Gallery
#####

#############################
# simple summaries
#############################
library(datasets)

#####
# one dimension
#####

# 5-number (min, Q1, mean, Q3, max)
summary(airquality$Temp)

# boxplot
boxplot(airquality$Temp, col="blue")
abline(h=75)  # add a static line for standards

# histogram
hist(airquality$Temp, col="green")
abline(v=75, lwd=5)  # vertical line at 75 with width 5
abline(v=median(airquality$Temp),col="magenta", lwd=2)
rug(airquality$Temp)  # plots all the data points under the histogram

hist(airquality$Temp, breaks=20) # manually set how many bars

# barplot
airquality$Mnth <- as.factor(airquality$Month)
barplot(table(airquality$Mnth),col="wheat", main="Number of Days per Month")

#####
# two dimensions (Lattics/ggplot2)
#####
# scatter plots
# smooth scatterplots

#####
# >2 dimensions
#####
# overlayed/multiple 2D plots; coplots
# color, size, shape indicators
# spinning plots
# actual 3-d plots (w/glasses)

# multiple boxplots
boxplot(Temp ~ Mnth, data=airquality, col="red")

# multiple histograms
par(mfrow = c(2,1), mar = c(4,4,2,1))  # set up stacked two high
hist(subset(airquality, Mnth==5)$Temp, col="green")
hist(subset(airquality, Mnth==8)$Temp, col="green")

# scatterplot
with(airquality, plot(Solar.R,Temp))
abline(h=75,   # horizontal
       lwd=2,  # line width
       lty=2)  # dashed

with(airquality, plot(Solar.R,Temp), col=Mnth) # add a color dimension

# multiple scatterplots
par(mfrow=c(1,2),mar=c(5,4,2,1))  # set up side by side
with(subset(airquality,Mnth==5),plot(Solar.R,Temp, main="May"))
with(subset(airquality,Mnth==8),plot(Solar.R,Temp, main="Aug"))
