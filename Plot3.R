path = paste0(getwd(), "/household_power_consumption.txt")

##############################
#read table from a specified path, rename columns
x<-read.table(file = path, skip = 1,sep = ";")
names(x) <- c("Date","Time","Global_active_power",
              "Global_reactive_power","Voltage","Global_intensity",
              "Sub_metering_1","Sub_metering_2","Sub_metering_3")

#subset data
data <- subset(x,x$Date =="1/2/2007" | x$Date == "2/2/2007")

#format date and time columns
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- strptime(data$Time, format="%H:%M:%S")
data[1:1440,"Time"] <- format(data[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data[1441:2880,"Time"] <- format(data[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
var2<-as.numeric(as.character(data$Global_active_power))
var3<-as.numeric(as.character(data$Sub_metering_1))
var4<-as.numeric(as.character(data$Sub_metering_2))
var5<-as.numeric(as.character(data$Sub_metering_3))

#build plot
plot(data$Time, var3, type = "l", col = "black", 
     xlab = "", ylab = "Energy sub metering")
lines(data$Time, var4, type = "l", col = "red")
lines(data$Time, var5, type = "l", col = "blue")
title("Energy sub-metering")
legend("topright", lty = 1, col = c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.4)

#save plot as png
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
