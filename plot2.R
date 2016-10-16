## Require packages
require("dplyr")
require("lubridate")

## Read data from source
rawData <- read.csv("household_power_consumption.txt", sep = ";")

## Reformat date
rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")

## Filter dataset with period of interest
filtered <- rawData %>% select(Date, Time, Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3) %>% filter(Date >= "2007-02-01" & Date <= "2007-02-02")

## Merge date and Time
mergedDateAndTime <- paste(filtered$Date, filtered$Time, sep = "-")

## Create a single date and time formated column
timeFormated <- ymd_hms(mergedDateAndTime)

## Create png with specified dimensions
png('plot2.png', width = 480, height = 480)

## Plot power against time
plot(y=filtered$Global_active_power, x=timeFormated, type="l", ylab = "Global Active Power (kilowatts)")

## Copy the displayed plot into the file
dev.copy(png,'plot2.png')
dev.off()