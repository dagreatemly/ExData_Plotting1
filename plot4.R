library(ggplot2)
initial <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 100)
classes <- sapply(initial, class)
tabAll <- read.table("household_power_consumption.txt", 
                     header = TRUE, sep = ";", 
                     na.strings = "?", 
                     colClasses = classes)

rm(initial)


currentFormat <- "%d/%m/%Y"
tabAll$Date <- as.Date(tabAll$Date, currentFormat)
dates <- tabAll$Date
dates <- as.character(dates)
target <- dates == "2007-02-01" | dates == "2007-02-02"
data <- tabAll[target,]
times <- data$Time
times <- as.character(times)
x <- paste(data$Date,times)
x <- strptime(x, "%Y-%m-%d %H:%M:%S")
par(mfrow=c(2,2))
with(data, {
     plot(x, data$Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)", mar = c(2, 4, 4, 2) + 0.1)
     plot(x, data$Voltage, type="l", ylab="Voltage", xlab = "datetime", mar = c(2, 4, 4, 2) + 0.1)
     plot(x, data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
          lines(x, data$Sub_metering_2, col= "red")
          lines(x, data$Sub_metering_3, col = "blue")
          legend("top", lty = 1, bty ="n", col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(x, data$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")
})
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()