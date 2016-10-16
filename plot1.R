## This script reads dowloaded data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## and creates a plot of global active power usage during the time of 2007-02-01 and 2007-02-01.
## The plot is named plot1.png and is saved in the current working directory.

## Require packages
require("dplyr")

## Read data from source
rawData <- read.csv("household_power_consumption.txt", sep = ";")

## Reformat date
rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")

## Filter dataset with period of interest
filtered <- rawData %>% select(Date, Time, Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02")

## Plot a histogram
hist(as.numeric(as.character(filtered$Global_active_power)), col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Create png with specified dimensions
png('plot1.png', width = 480, height = 480)

## Copy the displayed plot into the file
dev.copy(png,'plot1.png')
dev.off()