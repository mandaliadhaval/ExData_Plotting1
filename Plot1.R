library(data.table)

#import data into variable
pwrdata <- data.table::fread(input="household_power_consumption.txt")

# Subset the full data to obtain data on two mentioned dates:
pwrdata <- subset(pwrdata,(pwrdata$Date=="1/2/2007" | pwrdata$Date== "2/2/2007"))

#Chage class of date column to Date format
pwrdata$Date <-as.Date(pwrdata$Date,format="%d/%m/%Y")

#Check current active device
dev.cur()

#Check current memory & variable size in MB
gc()
object.size(pwrdata)/2^20


#Set device as PNG file
png("plot1.png",width = 480,height = 480)

#Create histogram with Red bars
hist(pwrdata$Global_active_power,col="red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")

#Close device
dev.off()