############################################################################################
# Coursera Course: Exploratory Data Analysis, Winter 2016
# Course Project 1, Part 1: Generate a Histogram of Global Active Power
#
#     plot1.R loads a UCI data set that contains information about power consumption of one
#     household and plots a histogram of the global active power from January 1-2 in 2007.
#
#     As described on the UCI website, global active power is in kilowatts. The data set
#     ranges from 74-3692 kilowatts. However, the data in the "target" figure posted by
#     the course instructors is divided by 500.The data here was also divied by 500 in
#     order to match their work.
#
#     github/sylvest00, 2015
###########################################################################################

# Clear the workspace and close any existing figures
rm(list = ls())
graphics.off()


# Read in the power consumption data set that is saved to the working directry
dataTableOriginal <- read.table("household_power_consumption.txt", sep=";",header=TRUE)
dT <- dataTableOriginal


# Change the dates to characters (from objects)
dT$Date <- strptime(dT$Date,format="%d/%m/%Y")


# Find data from Jan 1-2, 2007 and subset the table
day1_idx <- which(dT$Date == "2007-02-01")
day2_idx <- which(dT$Date == "2007-02-02")
idx <- cbind(day1_idx, day2_idx)
idx <- sort(idx)
dT <- dT[idx,]


# Generate histogram using the base plot function 'hist'
hist(as.numeric(dT$Global_active_power)/500,
     main = "Global Active Power Histogram",
     xlab = "Global Active Power (Kilowatts / 500)",
     xlim = c(0,8),
     ylim = c(0,1400),
     las = 1,
     freq = TRUE,
     col='red',
     breaks = c(seq(0,8,0.5)))

# Save as a png
dev.copy(png,'plot1.png',width=480,height=480)
dev.off()