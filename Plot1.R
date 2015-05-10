## R code for Exploratory Data Analysis Class Project #1
## File is used to create a plot of the household electric consumption data from the UC 
## Learning Repository Irvine Machine
## The data was retrieved from the UCI website (https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption)
## on 2015-05-09

## Plot #1 is a histogram of the Global Active Power readings for 2007-02-01 and 2007-02-02

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

## Remove the unneeded Time column
dataToPlot$Time <- NULL

## Convert dates and times from factors to date and time classes
dataToPlot$Date <- strptime(dataToPlot$Date, "%Y-%m-%d %H:%M:%S")

##set the margins to something reasonable
par(mar = c(5, 5, 5, 5))

##create the PNG file
png(file = "Plot1.png", width = 480, height = 480, units = "px")

#create the histogram
hist(dataToPlot$Global_active_power, main = "Global Active Power", xlab = 'Global Active Power (kilowatts)',   col = "Red")

##complete the file
dev.off()

