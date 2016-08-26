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


#   Creating a function for the plot2.png file:
plot2 <- function() {
  # Generating plot 2
  plot(x.subset$Time,x.subset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  # Copying plot 2
  dev.copy(png, file = "plot2.png", width = 480, height = 480)
  dev.off()
  
  #Message
  cat("plot2 succesfully stored in the directory:", getwd())
}

plot2()   #executing plot2() function to create the plot