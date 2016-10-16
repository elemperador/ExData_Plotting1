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
png('plot4.png', width = 480, height = 480)

## Configure graphs layout
par(mfrow = c(2, 2))

## Plot all graphs

## First Plot
plot(y=filtered$Global_active_power, x=timeFormated, type="l", ylab = "Global Active Power (kilowatts)")

## Second Plot
plot(y=filtered$Voltage, x=timeFormated, type = "l", ylab = "Voltage")

## Third Plot
plot(y=as.numeric(as.character(filtered$Sub_metering_1)), x=timeFormated, type="l", ylab = "Energy sub metering")
lines(y=as.numeric(as.character(filtered$Sub_metering_2)), x=timeFormated, col="red")
lines(y=as.numeric(as.character(filtered$Sub_metering_3)), x=timeFormated, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

## Fourth Plot
plot(y=filtered$Global_reactive_power, x=timeFormated, type = "l", ylab = "Global_reactive_power")

dev.copy(png,'plot4.png')
dev.off()