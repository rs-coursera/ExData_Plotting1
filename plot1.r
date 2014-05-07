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
d$Date<-as.Date(as.character(d$Date), format="%d/%m/%Y")
d<-d[d$Date>="2007-02-01" & d$Date<="2007-02-02",]

#Plot the graph
png("plot1.png", width=480, height=480)
hist(d$Global_active_power, col="red"
     , xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
