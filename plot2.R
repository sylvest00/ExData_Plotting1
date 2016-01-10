############################################################################################
# Coursera Course: Exploratory Data Analysis, Winter 2016
# Course Project 1, Part 2: Generate a Histogram of Global Active Power
#
#     plot2.R loads a UCI data set that contains information about power consumption of one
#     household and generates a plot of global active power vs. day from January 1-2 in 2007.
#
#     As described on the UCI website, global active power is in kilowatts. The data set
#     ranges from 74-3692 kilowatts. However, the data in the "target" figure posted by
#     the course instructors is divided by 500.The data here was also divied by 500 in
#     order to match their work.
#
#     Libraries required: chron
#
#     github/sylvest00, 2015
###########################################################################################


# Clear workspace and close all figures
rm(list = ls())
graphics.off()

# Load calendar library
library(chron)

# Read in power consumption table
dataTableOriginal <- read.table("household_power_consumption.txt", sep=";",header=TRUE)
dT <- dataTableOriginal

# convert date objects to characters
dT$Date <- strptime(dT$Date,format="%d/%m/%Y")

# Subset the table so that target dates are remaining
day1_idx <- which(dT$Date == "2007-02-01")
day2_idx <- which(dT$Date == "2007-02-02")
idx <- cbind(day1_idx, day2_idx)
idx <- sort(idx)
dT <- dT[idx,]


# Adjust to match range of instructor figure
dT$Global_active_power <- as.numeric(dT$Global_active_power)/500


# Generate x values so that the data is ordered properly and the
# x-axis labels are easily manipulable. Here, they are converted
# to minutes ranging from 1 to 2879
minPerDay <- 60*24;
x <- minPerDay*as.numeric(times(dT$Time))
day1_idx <- which(dT$Date == "2007-02-01")
day2_idx <- which(dT$Date == "2007-02-02")
x[day2_idx] <- x[day2_idx] + minPerDay

# Open PNG graphics device
png("plot2.png",width=480,height=480,bg="transparent")

# Plot global active power vs. time
plot(x,dT$Global_active_power,
     type="l",
     main = "Global Active Power \n January 1, 2007 - Janurary 2, 2007",
     xlab = "Day",
     xaxt = "n",
     ylab = "Global Acive Power (Kilowatts /500)"
)


# Add x label
datesList <- unique(dT$Date)
dayLabel <- c(weekdays(as.Date(c(datesList,as.Date(datesList[2])+2),'%Y-%m-%d')))
axis(1, at = c(1,minPerDay+1,length(x)), labels = dayLabel)


# Save figure as a PNG
dev.off()