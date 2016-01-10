############################################################################################
# Coursera Course: Exploratory Data Analysis, Winter 2016
# Course Project 1, Part 1: Generate a Histogram of Global Active Power
#
#     plot1.R loads a UCI data set that contains information about power consumption of one
#     household and plots a histogram of the global active power from January 1-2 in 2007.
#
#
#     github/sylvest00, 2016
###########################################################################################

# Clear the workspace and close any existing figures
rm(list = ls())
graphics.off()


# Read in the power consumption data set that is saved to the working directry
dataTableOriginal <- read.table("household_power_consumption.txt", sep=";",header=TRUE, stringsAsFactors = FALSE)
dT <- dataTableOriginal


# Change the dates to characters (from objects)
dT$Date <- strptime(dT$Date,format="%d/%m/%Y")


# Find data from Jan 1-2, 2007 and subset the table
day1_idx <- which(dT$Date == "2007-02-01")
day2_idx <- which(dT$Date == "2007-02-02")
idx <- cbind(day1_idx, day2_idx)
idx <- sort(idx)
dT <- dT[idx,]

# Open PNG graphics device
png("plot1.png",width=480,height=480,bg="transparent")

# Generate histogram using the base plot function 'hist'
hist(as.numeric(dT$Global_active_power),
     main = "Global Active Power Histogram",
     xlab = "Global Active Power (Kilowatts)",
     xlim = c(0,8),
     ylim = c(0,1400),
     las = 1,
     freq = TRUE,
     col='red',
     breaks = c(seq(0,8,0.5)))

# Save as a png
dev.off()