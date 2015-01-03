require(data.table)
#fread in the dataset initially setting all columns to characters allowing all data to be read in 
#and avoiding any issues with data conversions on the load. Any required conversions are done subsequently
DT<-fread("household_power_consumption.txt",colClasses='character')
setkey(DT,Date)
#subset the dataset to keep only the 2 required dates
DT<-DT[c("1/2/2007","2/2/2007")]
require(lubridate)
#convert Sub_meterings from char to numeric and Date&Time to datetime
DT[,datetime:=dmy_hms(paste(Date, Time))]
for (col in c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) set(DT, j=col, value=as.numeric(DT[[col]]))
#set graphing device to png - note width = 480, height = 480 are the default values
png(file = "plot3.png",bg = "transparent")
#first calculate the ranges for X and Y so the graph is properly scaled 
yrange<-range(c(DT$Sub_metering_1,DT$Sub_metering_2,DT$Sub_metering_3))
xrange<-range(DT$datetime)
#plot graph with option "n" so multiple lines could be added later
plot(xrange,yrange,type="n", xlab="",ylab="Energy sub metering" ,pch=20)
lines(DT$datetime, DT$Sub_metering_1, type="l", col="black") 
lines(DT$datetime, DT$Sub_metering_2, type="l", col="red") 
lines(DT$datetime, DT$Sub_metering_3, type="l", col="blue") 
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty=c(1,1,1))
dev.off()