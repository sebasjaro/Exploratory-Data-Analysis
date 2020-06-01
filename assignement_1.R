dirtectorio <- dir()
library(lubridate)
data <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";")
new_data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007" ,]
new_data$Date <- as.Date(new_data$Date, format = "%d/%m/%Y")
new_data$Time <- paste(new_data$Date,new_data$Time,sep="")
new_data$Time <- strptime(new_data$Time, format = "%Y-%m-%d %H:%M:%S")
new_data$Global_active_power <- as.character(new_data$Global_active_power)
new_data$Global_active_power <- as.numeric(new_data$Global_active_power)

#Plot 1

char1 <- "Global Active Power"
char2 <- paste(char1,"(kilowatts)", sep = " ")
png(file="fig_1.png")
hist(new_data$Global_active_power, col="red",main = char1, xlab = char2)
dev.off()

#Plot 2
png(file="fig_2.png")
plot(new_data$Time,new_data$Global_active_power, type = "l", xlab = "",ylab = char2)
dev.off()

#Plot 3
new_data$Sub_metering_1 <- as.character(new_data$Sub_metering_1)
new_data$Sub_metering_1 <- as.numeric(new_data$Sub_metering_1)
new_data$Sub_metering_2 <- as.character(new_data$Sub_metering_2)
new_data$Sub_metering_2 <- as.numeric(new_data$Sub_metering_2)
char3 = "Energy sub metering"
char4 = "Sub_metering_1"
char5 = "Sub_metering_2"
char6 = "Sub_metering_3"
png(file="fig_3.png")
plot(new_data$Time,new_data$Sub_metering_1, type = "l", xlab = " ",ylab = char3)
lines(new_data$Time,new_data$Sub_metering_2, col = "red")
lines(new_data$Time,new_data$Sub_metering_3, col = "blue")
legend("topright", col = c(1,2,4), lty = 1, legend = c(char4,char5,char6))
dev.off()

#Plot 4
new_data$Voltage <- as.character(new_data$Voltage)
new_data$Voltage <- as.numeric(new_data$Voltage)
new_data$Global_reactive_power <- as.character(new_data$Global_reactive_power)
new_data$Global_reactive_power <- as.numeric(new_data$Global_reactive_power)
png(file = "fig_4.png")
par(mfrow = c(2,2))
with(new_data, {plot(Time,Global_active_power, type = "l", ylab = char1)
                plot(Time,Voltage, type = "l",xlab = "datetime")
                plot(Time,Sub_metering_1, type = "l", xlab = " ",ylab = char3)
                lines(Time,Sub_metering_2, col = "red")
                lines(Time,Sub_metering_3, col = "blue")
                legend("topright", col = c(1,2,4), lty = 1, legend = c(char4,char5,char6))
                plot(Time,Global_reactive_power, type = "l", xlab = "datetime")
})
dev.off()
