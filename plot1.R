require(data.table)
DT<-fread("household_power_consumption.txt",colClasses='character')
setkey(DT,Date)
DT<-DT[c("2/1/2007","2/2/2007")]
require(lubridate)
DT[,DateTime:=dmy_hms(paste(Date, Time))]
DT[ ,c("Date","Time") := NULL]
#DT[, lapply(.SD, as.numeric), by=DateTime]
for (col in setdiff(names(DT), "DateTime")) set(DT, j=col, value=as.numeric(DT[[col]]))