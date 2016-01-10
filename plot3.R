############################################################################################
# Coursera Course: Exploratory Data Analysis, Winter 2016
# Course Project 1, Part 3: Generate a Histogram of Global Active Power
#
#     plot3.R loads a UCI data set that contains information about power consumption of one
#     household and generates a plot of sub meter values vs. day from January 1-2 in 2007.
#
#     Libraries required: chron
#
#     github/sylvest00, 2016
###########################################################################################


# Clear workspace and close all figures
rm(list = ls())
graphics.off()


# Load calendar library
library(chron)


# Read in data from a TXT file and store values in a table
dataTableOriginal <- read.table("household_power_consumption.txt", sep=";",header=TRUE, stringsAsFactors = FALSE)
dT <- dataTableOriginal


# Convert date objects to characters
dT$Date <- strptime(dT$Date,format="%d/%m/%Y")


# Subset the table to keep data from target dates
day1_idx <- which(dT$Date == "2007-02-01")
day2_idx <- which(dT$Date == "2007-02-02")
idx <- cbind(day1_idx, day2_idx)
idx <- sort(idx)
dT <- dT[idx,]


# Subset the table in order to keep neccessary columns
dT <- dT[,c(1,2,7,8,9)]
dT$Sub_metering_1 <- as.numeric(dT$Sub_metering_1)
dT$Sub_metering_2 <- as.numeric(dT$Sub_metering_2)
dT$Sub_metering_3 <- as.numeric(dT$Sub_metering_3)


# Find range for y axis
lineRange1 <- matrix(range(dT$Sub_metering_1), ncol = 2)
lineRange2 <- matrix(range(dT$Sub_metering_2), ncol = 2)
lineRange3 <- matrix(range(dT$Sub_metering_3), ncol = 2)
lineRange0 <- rbind(lineRange1,lineRange2,lineRange3)
lineRange <- c(min(lineRange0),max(lineRange0))


# Generate x values so that the data is ordered properly and the
# x-axis labels are easily manipulable. Here, they are converted
# to minutes ranging from 1 to 2879
day1_idx <- which(dT$Date == "2007-02-01")
day2_idx <- which(dT$Date == "2007-02-02")
minPerDay <- 60*24;
x <- minPerDay*as.numeric(times(dT$Time))
x[day2_idx] <- x[day2_idx] + minPerDay 


# Open the PNG graphics device
png("plot3.png",width=480,height=480,bg="transparent")


# Plot of sub metering 1 vs. time
plot(x,dT$Sub_metering_1,
     type="l",
     xlab = "Day",
     ylim = c(0,lineRange[2]),
     xaxt = "n",
     ylab = "Energy Sub Metering",
     col = "black"
)


# Add sub metering 2 to the existing plot
lines(x,dT$Sub_metering_2, col = "red")


# Add submetering 3 to the existing plot
lines(x,dT$Sub_metering_3, col = "blue")


# Label x-axis
datesList <- unique(dT$Date)
dayLabel <- c(weekdays(as.Date(c(datesList,as.Date(datesList[2])+2),'%Y-%m-%d')))
axis(1, at = c(1,minPerDay+1,length(x)), labels = dayLabel)


# Add a title to the plot
title("Energy Sub Metering \n Janurary 1, 2007 - Janurary 2, 2007")


# Legend
headerNames <- colnames(dT)[3:5]
legend(x = 'topright',headerNames,col = c("black","red","blue"),lwd = c(2.5,2.5,2.5),bty="n")

# Close PNG graphics device
dev.off()