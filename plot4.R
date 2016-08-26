if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "hpc.zip")
  hpc <- "hpc.zip"
  hpc.un <- unzip(hpc)
  unlink(hpc)
}   #downloading and unzipping the file to the cwd

x <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")   # reading the entire table

x.sub <- subset(x, Date == "1/2/2007")
x.sub1 <- subset(x, Date == "2/2/2007")
x.subset <- rbind(x.sub, x.sub1)   # subsetting and reading for only the required dates in the table

rm(x)
rm(x.sub)
rm(x.sub1)   # removing data not needed in the environment

x.subset$Date <- as.Date(x.subset$Date, format = "%d/%m/%Y")   # converting date from factor to date type variable

str(x.subset)   # should display x.subset$Date as a date variable.

x.subset$Time <- strptime(paste(x.subset$Date, x.subset$Time), "%Y-%m-%d %H:%M:%S")   # converting date from factor to time type variable

str(x.subset)   # should display x.subset$Time as a POSIXlt variable.

# transforming variables to numeric:

x.subset$Global_active_power <- as.numeric(as.character(x.subset$Global_active_power))
x.subset$Global_reactive_power <- as.numeric(as.character(x.subset$Global_reactive_power))
x.subset$Voltage <- as.numeric(as.character(x.subset$Voltage))
x.subset$Sub_metering_1 <- as.numeric(as.character(x.subset$Sub_metering_1))
x.subset$Sub_metering_2 <- as.numeric(as.character(x.subset$Sub_metering_2))
x.subset$Sub_metering_3 <- as.numeric(as.character(x.subset$Sub_metering_3))


#   Creating a function for the plot4.png file:
plot4 <- function() {
  
  # Setting 4 plots on the same device:
  par(mfrow=c(2,2))
  
  # Generating plot a:  
  plot(x.subset$Time,x.subset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  # Generating plot b:  
  plot(x.subset$Time,x.subset$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  # Generating plot c:  
  plot(x.subset$Time,x.subset$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
  lines(x.subset$Time,x.subset$Sub_metering_2,col="red")
  lines(x.subset$Time, x.subset$Sub_metering_3,col="blue")
  legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1  ", "Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=0.7)
  
  # Generating plot d:  
  plot(x.subset$Time,x.subset$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
  
  # Copying plot 4:
  dev.copy(png, file = "plot4.png", width = 480, height = 480)
  dev.off()
  
  #Message
  cat("plot4 succesfully stored in the directory:", getwd())
}

plot4()   #executing plot4() function to create the plot