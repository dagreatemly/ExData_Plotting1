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
data <- tabAll[target,c("Date","Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]
times <- data$Time
times <- as.character(times)
x <- paste(data$Date,times)
x <- strptime(x, "%Y-%m-%d %H:%M:%S")
data <- data[,3:5]
data <- cbind(x, data)
plot(x, data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(x, data$Sub_metering_2, col= "red")
lines(x, data$Sub_metering_3, col = "blue")
legend("topright", bty= "n", inset=c(0.14, 0),lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()