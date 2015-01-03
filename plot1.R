require(data.table)
#fread in the dataset initially setting all columns to characters allowing all data to be read in 
#and avoiding any issues with data conversions on the load. Any required conversions are done subsequently
DT<-fread("household_power_consumption.txt",colClasses='character')
setkey(DT,Date)
#subset the dataset to keep only the 2 reuired dates
DT<-DT[c("1/2/2007","2/2/2007")]
#convert Global_active_power from char to numeric
DT[ ,Global_active_power:= as.numeric(Global_active_power)]
#set graphing device to png - note width = 480, height = 480 are the default values
png(file = "plot1.png", bg = "transparent")
#draw histogram
hist(DT$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red",ylim=c(0, 1200),pch=20)
dev.off()