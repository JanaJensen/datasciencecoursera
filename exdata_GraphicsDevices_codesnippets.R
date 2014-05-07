#############################
# Graphics Devices
#############################
# someplace where you can make a plot appear
#   - window on screen
#   - pdf/png/jpg/svg file
#
# when you make a plot, it has to be sent to a graphic device:
#
# Screens on various OS:
#   Mac:     quartz()
#   Windows: windows()
#   Linux:   x11()

# see list of available devices
?Devices

# sending a plot to a file device
pdf(file="myplot.pdf") # open PDF device and create file in working dir
with(faithful,plot(eruptions,waiting)) # generate plot
title(main="Old Faithful Geyser data") # annotate
dev.off() # close the file devise
# go look at plot on your computer


#############################
# file devices
#############################

#vector formats: (lines, modest # points)
#  - pdf - portable, resizeable, maybe not efficient
#  - svg - XML-based scalable vector grphics, supports animation and interactive
#          good for web-based
#  - win.metafile - Windows format
#  - postscript - better for non-Windows

# bitmap formats: (images, large # points)
#  - png - good for line drawings, lossless compression, doesn't resize well
#  - jpeg - photos, natural scenes, not great for line drawings
#  - tiff
#  - bmp - native Windows bitmapped


#############################
# multiple open devices
#############################
# plotting occurs on one at a time
# every open device assigned integer >= 2
dev.cur()  # display current device
dev.set(2) # change to device 2


#############################
# copying plots
#############################
#  dev.copy: copy from one device to another
#  dev.copy2pdf: copy to a pdf
#  note: not an exact operation, result may not be identical
library(datasets)
with(faithful,plot(eruptions,waiting)) # create plot to screen
title(main="Old Faithful Geyser data")  # annotate
dev.copy(png,file="geyserplot.png")  # copy to png file, note device number
dev.off(3)  # close the png device

