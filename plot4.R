library(sqldf)

## Read data only for the two days
x <- read.csv.sql("household_power_consumption.txt", 
                  sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"',
                  sep = ";")
closeAllConnections()

## This would be an alternative way of reading the data
# x <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE)
# x <- subset(x, x$Date=="1/2/2007" | x$Date=="2/2/2007")


## Generates the datetime variable for plotting
datetime <- as.POSIXct(paste(x$Date, x$Time), format="%d/%m/%Y %H:%M:%S")

## Converts Date and Time variables to Date/Time classes
x$Date <- as.Date(x$Date, format = "%d/%m/%Y")
x$Time <- as.POSIXct( strptime(x$Time, format = "%H:%M:%S") )

## Plot
png(filename="plot4.png",
    width = 480, height = 480, units = "px")

par(mfrow = c(2,2))

with(x, plot(Global_active_power ~ datetime, type="l", xlab = ""))

with(x, plot(Voltage ~ datetime, type="l"))

with(x, plot(Sub_metering_1 ~ datetime, type="n", 
             xlab = "",
             ylab = "Energy sub metering"))
with(x, lines(Sub_metering_1 ~ datetime, col = "black"))
with(x, lines(Sub_metering_2 ~ datetime, col = "red"))
with(x, lines(Sub_metering_3 ~ datetime, col = "blue"))
legend("topright",
       lty = 1,
       box.lty = 0, inset = .02,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(x, plot(Global_reactive_power ~ datetime, type="l"))

dev.off()
