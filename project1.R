
p <- function()
{
  #dataLoc <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  #download.file(dataLoc, "power.zip")
  
  unzipDataLoc <- unzip("power.zip")
  
  #Reading in between the dates
  data <- read.csv(unzipDataLoc, na.strings = "?", skip=66637, nrow=2880, col.names = c("Date","Time", "Global_active_power","Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";")
  
  
  #Removing na from the global active power
  data <- data[complete.cases(data[,3]),]
  data$Datetime = paste(data$Date, data$Time, sep=" ")
  data$Datetime <-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
  
  #Setting the values as numeric
  data$Global_active_power <- as.numeric(data$Global_active_power)
  
  #First plot
  png("plot1.png")
  hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red" )
  dev.off()
  
  #Second plot
  png("plot2.png")
  plot(data$Datetime, data$Global_active_power, type="l", xlab = "",ylab = "Global Active Power (kilowatts)")
  dev.off()
  
  #Third plot
  png("plot3.png")
  plot(data$Datetime, data$Sub_metering_1, type="l", xlab = "",ylab = "Energy sub metering")
  lines(data$Datetime, data$Sub_metering_2, col = "red")
  lines(data$Datetime, data$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = .75, cex = .75)
  dev.off()
  
  #Fourth plot
  png("plot4.png")
  par(mfrow=c(2,2))
  plot(data$Datetime, data$Global_active_power, type="l", xlab = "",ylab = "Global Active Power (kilowatts)")
  
  plot(data$Datetime, data$Voltage, type="l", xlab = "datetime",ylab = "Voltage")
  
  plot(data$Datetime, data$Sub_metering_1, type="l", xlab = "",ylab = "Energy sub metering")
  lines(data$Datetime, data$Sub_metering_2, col = "red")
  lines(data$Datetime, data$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = .75, cex = .75, bty = "n")
  
  plot(data$Datetime, data$Global_reactive_power, type="l", xlab = "datetime", ylab =  "Global_reactive_power")
  dev.off()
}