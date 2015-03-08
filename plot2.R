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
data <- tabAll[target,c("Date","Time", "Global_active_power")]


times <- data$Time
times <- as.character(times)
x <- paste(data$Date,times)
x <- strptime(x, "%Y-%m-%d %H:%M:%S")
plot(x, data$Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()