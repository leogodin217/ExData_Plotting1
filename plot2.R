library(graphics)

# Create a PNG file with a plot of Global active power totals across Thursday, Friday and Saturdayd

# Download and unzip the file

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data/data.zip")
unzip("data/data.zip", exdir="data")

data = read.table("data/household_power_consumption.txt", header=TRUE, sep=";", na.strings=c("?"), stringsAsFactors=FALSE)

# Pull out data from 1/2/2007 and 2/2/2007
rows = data$Date == "1/2/2007" | data$Date == "2/2/2007"

timed_data = data[rows, ]

# Convert date and time to time
timed_data$Date = strptime(paste(timed_data$Date, timed_data$Time), format="%d/%m/%Y %H:%M:%S")

# Plot a line graph of Global active power to a PNG
png(filename="plot2.png", width=480, height=480)
plot(x=timed_data$Date, y=timed_data$Global_active_power, type="l", ylab="Global Active Power (Kilowatts)", xlab="")
dev.off()



