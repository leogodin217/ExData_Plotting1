library(graphics)

# Download and unzip the file

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data/data.zip")
unzip("data/data.zip", exdir="data")

data = read.table("data/household_power_consumption.txt", header=TRUE, sep=";", na.strings=c("?"), stringsAsFactors=FALSE)

# Pull out data from 1/2/2007 and 2/2/2007
rows = data$Date == "1/2/2007" | data$Date == "2/2/2007"

timed_data = data[rows, ]

# Convert date and time to time
timed_data$Date = strptime(paste(timed_data$Date, timed_data$Time), format="%d/%m/%Y %H:%M:%S")

# get the max x and y value for the y access and legend
y_range = range(0, timed_data$Sub_metering_1, timed_data$Sub_metering_2, timed_data$Sub_metering_3)
x_range = range(0, timed_data$Date)

# Create the plog
png(filename="plot3.png", width=480, height=480)
plot(x=timed_data$Date, y=timed_data$Sub_metering_1, type="l", ylim=y_range, main="", ylab="Energy sub metering", xlab="")
lines(x=timed_data$Date, y=timed_data$Sub_metering_2, type="l", col="red")
lines(x=timed_data$Date, y=timed_data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=names(timed_data[7:9]), col=c("black", "red", "blue"), lty=c(1, 1, 1))

dev.off()




