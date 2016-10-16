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

## Plot all data
plot(y=filtered$Sub_metering_1, x=timeFormated, type="l", ylab = "Energy sub metering")
lines(y=filtered$Sub_metering_2, x=timeFormated, col="red")
lines(y=filtered$Sub_metering_3, x=timeFormated, col="blue")

## Add legends
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

## Create png with specified dimensions
png('plot3.png', width = 480, height = 480)

## Copy the displayed plot into the file
dev.copy(png,'plot3.png')
dev.off()