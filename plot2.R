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
png(filename="plot2.png",
    width = 480, height = 480, units = "px")
par(mfrow = c(1,1))

with(x, plot(Global_active_power ~ datetime, type="l",
     xlab = "",
     ylab = "Global Active Power (kilwatts)"))

dev.off()


