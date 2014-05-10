#Download and extract file if it doesn't exist
#in the working directory
if (!file.exists("consumption.zip"))
    download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        , "consumption.zip")
if (!file.exists("household_power_consumption.txt"))
    unzip("consumption.zip")

# Load the dataset 
# convert date strings to date format
# clean the rows with NA values
# Filter only necessary range
d <- read.csv("household_power_consumption.txt", header=T, 
              sep=";", na.strings="?")
d <- d[complete.cases(d),]
d$DateTime <- strptime(paste(d$Date, d$Time), "%d/%m/%Y %H:%M:%S")
d$Date<-as.Date(as.character(d$Date), format="%d/%m/%Y")
d<-d[d$Date>="2007-02-01" & d$Date<="2007-02-02",]

# Plotting to image with english locale
# Could set Sys.setlocale("LC_TIME", "English")
# to print english week day names

png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2))

#1st Plot - Global Active Power
plot(x=d$DateTime, y=d$Global_active_power, type="l"
     , ylab="Global Active Power", xlab="")


#2nd plot - Voltage
plot(x=d$DateTime, y=d$Voltage, type="l"
     , ylab="Voltage", xlab="datetime")

#3rd plot
plot(x=d$DateTime, y=d$Sub_metering_1, type="l"
     , ylab="Energy Sub Metering", xlab="")
lines(x=d$DateTime, y=d$Sub_metering_2, col="red")
lines(x=d$DateTime, y=d$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), pch=c(NA, NA, NA)
       , lwd=c(1,1,1)
       , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4th plot - Global reactive power
plot(x=d$DateTime, y=d$Global_reactive_power, type="l"
     , ylab="Global_reactive_power", xlab="datetime")


dev.off()
