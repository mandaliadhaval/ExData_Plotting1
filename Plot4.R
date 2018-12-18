library(data.table)

#import data into variable
pwrdata <- data.table::fread(input="household_power_consumption.txt",na.strings = "?")

# Subset the full data to obtain data on two mentioned dates:
pwrdata <- subset(pwrdata,(pwrdata$Date=="1/2/2007" | pwrdata$Date== "2/2/2007"))

#Chage class of date column to Date format
pwrdata$Date <-as.Date(pwrdata$Date,format="%d/%m/%Y")

#Convert Date to DateTime format
pwrdata$DateTime <- as.POSIXct(paste(pwrdata$Date, pwrdata$Time))

#Check current active device
dev.cur()

#Set device as PNG file
png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

with(pwrdata,plot(DateTime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab = ""))
with(pwrdata,plot(DateTime,Voltage,type="l",ylab="Voltage", xlab = "datetime"))

with(pwrdata,plot(DateTime,Sub_metering_1,type="l",ylab="Energy sub metering", xlab = ""))
lines(pwrdata$DateTime,pwrdata$Sub_metering_2,col="red",type="l")
lines(pwrdata$DateTime,pwrdata$Sub_metering_3,col="blue",type="l")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))

with(pwrdata,plot(DateTime,Global_reactive_power,type="l",ylab="Global_reactive_power", xlab = "datetime"))

dev.off()