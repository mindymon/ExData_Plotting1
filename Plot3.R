## R code for Exploratory Data Analysis Class Project #1
## File is used to create a plot of the household electric consumption data from the UC 
## Learning Repository Irvine Machine
## The data was retrieved from the UCI website (https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption)
## on 2015-05-09

## Plot #3 is a line chart for all three Sub_metering readings for 2007-02-01 and 2007-02-02

## read in data set
## determine the classes of the data, based on a few rows, to increase efficiency
## of read.table().  From http://www.biostat.jhsph.edu/~rpeng/docs/R-large-tables.html 
learnData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows = 5)
classes <- sapply(learnData, class)
allData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings ="?", colClasses = classes)

##Convert Date from factor to date
allData$Date <- as.Date(allData$Date, format = "%d/%m/%Y")

##subset data for only the data in question 2007-02-01 and 2007-02-02
dataToPlot <- subset(allData, Date == "2007-02-01" | Date == "2007-02-02")

##combine Date and Time
dataToPlot$Date <-paste(dataToPlot$Date, dataToPlot$Time, sep = " ")

##remove the unneeded Time column
dataToPlot$Time <- NULL

##convert dates and times from factors to date and time classes
dataToPlot$Date <- strptime(dataToPlot$Date, "%Y-%m-%d %H:%M:%S")

##set the margins to something reasonable
par(mar = c(5, 5, 5, 5))

##create the PNG file
png(file = "Plot3.png", width = 480, height = 480, units = "px")

#create the line chart with the first sub metering observations
plot(x = dataToPlot$Date, y = dataToPlot$Sub_metering_1, xlab = " ", ylab = 'Energy sub metering',   col = "Black", type = "l")

##add the other two lines
lines(x = dataToPlot$Date, y = dataToPlot$Sub_metering_2, col = "Red", type = "l", lwd = 2)
lines(x = dataToPlot$Date, y = dataToPlot$Sub_metering_3, col = "Blue", type = "l", lwd = 2)

##add the legend with the titles and lines
legend("topright", c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), lty = c(1, 1, 1), lwd = c(2.5, 2.5, 2.5), col = c("Black", "Red", "Blue"))

##complete the file
dev.off()