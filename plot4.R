require(data.table)
#fread in the dataset initially setting all columns to characters allowing all data to be read in 
#and avoiding any issues with data conversions on the load. Any required conversions are done subsequently
DT<-fread("household_power_consumption.txt",colClasses='character')
setkey(DT,Date)
#subset the dataset to keep only the 2 required dates
DT<-DT[c("1/2/2007","2/2/2007")]
require(lubridate)
#perform data type conversions
DT[,datetime:=dmy_hms(paste(Date, Time))]
for (col in c("Global_reactive_power","Voltage","Sub_metering_1","Sub_metering_2","Sub_metering_3")) set(DT, j=col, value=as.numeric(DT[[col]]))
#set graphing device to png - note width = 480, height = 480 are the default values
png(file = "plot4.png",bg = "transparent")
par(mfrow=c(2,2),mar=c(5.1, 4, 2, 2),pch=20)

#Plot 4 graphs as per required - I'm assuming 3 graphs out of 4 show 
# small dots connected by lines (not just lines!!!)
####################################################################################
plot(range(DT$datetime),range(DT$Global_active_power),type="n",ylab="Global Active Power",xlab="")
lines( DT$datetime,DT$Global_active_power, col="gray30",lwd=2 )
points( DT$datetime,DT$Global_active_power, col="black",cex=0.001 )

####################################################################################
plot(range(DT$datetime),range(DT$Voltage),type="n",ylab="Voltage",xlab="datetime")
lines( DT$datetime,DT$Voltage, col="gray30" ,lwd=1.5)
points( DT$datetime,DT$Voltage, col="black",cex=0.001 )

####################################################################################
yrange<-range(c(DT$Sub_metering_1,DT$Sub_metering_2,DT$Sub_metering_3))
xrange<-range(DT$datetime)
plot(xrange,yrange,type="n", xlab="",ylab="Energy sub metering" )
lines(DT$datetime, DT$Sub_metering_1, type="l", col="black") 
lines(DT$datetime, DT$Sub_metering_2, type="l", col="red") 
lines(DT$datetime, DT$Sub_metering_3, type="l", col="blue") 
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty=c(1,1,1))
####################################################################################
plot(range(DT$datetime),range(DT$Global_reactive_power),type="n",ylab="Global_reactive_power",xlab="datetime")
lines( DT$datetime,DT$Global_reactive_power, col="gray20" )
points( DT$datetime,DT$Global_reactive_power, col="black",cex=0.001 )

dev.off()