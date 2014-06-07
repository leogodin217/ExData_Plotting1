library(graphics)

# Creates a png file with a histogram of global active power from 2007-02-01 and 2007-02-02

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

# Save the histogram to a png
png(filename="plot1.png", width=480, height=480)
hist(timed_data$Global_active_power, col="Red", xlab="Global Active Power (Kilowatts)", main="Global Active Power")
dev.off()



