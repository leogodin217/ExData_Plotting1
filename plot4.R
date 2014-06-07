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

# Create a PNG with four charts 
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Plot the first graph, a line graph of Global active power to a PNG

plot(x=timed_data$Date, y=timed_data$Global_active_power, type="l", ylab="Global active power", xlab="")

# Plot the second graph, a graph of voltage 

plot(x=timed_data$Date, y=timed_data$Voltage, type="l", ylab="Voltage", xlab="")

# Plot the third graph of sub metering
# get the max x and y value for the y access and legend
y_range = range(0, timed_data$Sub_metering_1, timed_data$Sub_metering_2, timed_data$Sub_metering_3)
x_range = range(0, timed_data$Date)

# Create the third plot showing Sub_metering

plot(x=timed_data$Date, y=timed_data$Sub_metering_1, type="l", ylim=y_range, main="", ylab="Energy sub metering", xlab="")
lines(x=timed_data$Date, y=timed_data$Sub_metering_2, type="l", col="red")
lines(x=timed_data$Date, y=timed_data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=names(timed_data[7:9]), col=c("black", "red", "blue"), lty=c(1, 1, 1), cex=.75, bty="n")

# Create the fourth plot, Global active power less than or equal to .5

plot(x=timed_data$Date, y=timed_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()



