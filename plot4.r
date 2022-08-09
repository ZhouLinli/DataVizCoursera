library(dplyr)
library(lubridate)
library(readr)
#read data from 2007/2/1-2/2
t <- read_delim("household_power_consumption.txt",
                delim = ";",#delimiter of different cols
                na    = c("?"),#turn ? into na values
                col_types = list(col_date(format = "%d/%m/%Y"),#format data type
                                 col_time(format = ""),#format to character
                                 col_number(),#format numeric for the 3-9 cols
                                 col_number(),
                                 col_number(),
                                 col_number(),
                                 col_number(),
                                 col_number(),
                                 col_number())) %>%
  filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))#filter 2007/2/1-2 observations

#observations/rows have no missing values across the entire sequence
t <- t[complete.cases(t),]

# Combine Date and Time column
t<-mutate(t, datetime = ymd_hms(paste(Date, Time)))



#plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(t, {
  #graph on Top Left
  plot(Global_active_power~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  #graph on top right
  plot(Voltage~datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  #graph on bottom left
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  #graph on bottom right
  plot(Global_reactive_power~datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})


#save plot
dev.copy(png, "plot4.png",
         width  = 480,
         height = 480)

dev.off()