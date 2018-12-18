library(data.table)

#import data into variable
pwrdata <- data.table::fread(input="household_power_consumption.txt",na.strings = "?")

# Subset the full data to obtain data on two mentioned dates:
pwrdata <- subset(pwrdata,(pwrdata$Date=="1/2/2007" | pwrdata$Date== "2/2/2007"))

#Chage class of date column to Date format
pwrdata$Date <-as.Date(pwrdata$Date,format="%d/%m/%Y")
pwrdata$Global_active_power <-as.numeric(pwrdata$Global_active_power)

#Convert Date to DateTime format
pwrdata$DateTime <- as.POSIXct(paste(pwrdata$Date, pwrdata$Time))

#Check current active device
dev.cur()

#Set device as PNG file
png("plot2.png", width = 480, height = 480)

#Plot chart with type as line
with(pwrdata,plot(DateTime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab = ""))

#Close device
dev.off()
