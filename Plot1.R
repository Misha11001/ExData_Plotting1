path = paste0(getwd(), "/household_power_consumption.txt")

##############################
#read table from a specified path, rename columns
x<-read.table(file = path, skip = 1,sep = ";")
names(x) <- c("Date","Time","Global_active_power",
              "Global_reactive_power","Voltage","Global_intensity",
              "Sub_metering_1","Sub_metering_2","Sub_metering_3")

#subset data
data <- subset(x,x$Date =="1/2/2007" | x$Date == "2/2/2007")
var1<-as.numeric(as.character(data$Global_active_power))

#build plot
hist(var1,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

#save plot as png
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
