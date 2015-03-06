# PLot 3
library(dplyr)
ibrary(lubridate)
library(sqldf)
library(tcltk)
library(datasets)

# setting English names to dates
Sys.setlocale("LC_TIME", "en_US.UTF-8") 

# Reading partial table using sqldf's read.csv2.sql
mytbl <- read.csv2.sql(fl, sql =" select * from file where Date ='1/2/2007' OR Date ='2/2/2007'", header = TRUE, sep=";", dec="." )

#converting to tbl-df
tbl2 <- tbl_df(mytbl)

#making a new table, by creating a combination of Date and Time  and Taking Global_active_power from the parent table
tbl3 <- tbl2 %>%
    mutate( date = dmy(Date) + hms(Time), "GMT") %>%
    select(date,Sub_metering_1, Sub_metering_2, Sub_metering_3 )

#open png device
png(file = "plot3.png", width = 480, height = 480)

# creating the line plots
with( tbl3,{
    par(mar = c(4,4,4,2))
    plot(date, Sub_metering_1,type="l",  xlab="", ylab="Energy Sub metering", ylim = range(Sub_metering_1), col ="black") 
    lines(date, Sub_metering_2,type="l",   col ="red") 
    lines(date, Sub_metering_3,type="l",  col = "blue") 
    legend("topright",   c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  col = c("black", "blue", "red"), lty=1, lwd=2)
  
})

dev.off()
