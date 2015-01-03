require(data.table)
#fread in the dataset initially setting all columns to characters allowing all data to be read in 
#and avoiding any issues with data conversions on the load. Any required conversions are done subsequently
DT<-fread("household_power_consumption.txt",colClasses='character')
setkey(DT,Date)
#subset the dataset to keep only the 2 required dates
DT<-DT[c("1/2/2007","2/2/2007")]
require(lubridate)
#convert Global_active_power from char to numeric and Date&Time to datetime
DT[,datetime:=dmy_hms(paste(Date, Time))]
DT[ ,Global_active_power:= as.numeric(Global_active_power)]
#set graphing device to png - note width = 480, height = 480 are the default values
png(file = "plot2.png",bg = "transparent")
#I'm assuming that the graph has darkgrey lines and black dots 
#it's hard to see & guess just based on the png image provided
plot(range(DT$datetime),range(DT$Global_active_power),type="n",ylab="Global Active Power (kilowatts)",xlab="")
lines( DT$datetime,DT$Global_active_power, col="gray30",lwd=2 )
points( DT$datetime,DT$Global_active_power, col="black", pch=20,cex=0.001 )
dev.off()