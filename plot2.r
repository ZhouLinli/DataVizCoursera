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




#plot2
plot(Global_active_power~datetime, data=t, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")

plot(Global_active_power ~ datetime, data=t, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)


#save plot
dev.copy(png, "plot2.png",
         width  = 480,
         height = 480)

dev.off()

