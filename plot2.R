p2 <- function()
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
  
  #Second plot
  png("plot2.png")
  plot(data$Datetime, data$Global_active_power, type="l", xlab = "",ylab = "Global Active Power (kilowatts)")
  dev.off()
}