require(data.table)
DT<-fread("household_power_consumption.txt",colClasses='character')
setkey(DT,Date)
DT<-DT[c("1/2/2007","2/2/2007")]
require(lubridate)
DT[,DateTime:=dmy_hms(paste(Date, Time))]
DT[ ,Global_active_power:= as.numeric(Global_active_power)]
png(file = "plot2.png",bg = "transparent")
plot(DT$DateTime,DT$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()