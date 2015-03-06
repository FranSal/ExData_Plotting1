# PLot 2
library(dplyr)
ibrary(lubridate)
library(sqldf)
library(tcltk)
library(datasets)




mytbl <- read.csv2.sql(fl, sql =" select * from file where Date ='1/2/2007' OR Date ='2/2/2007'", header = TRUE, sep=";", dec="." )
tbl2 <- tbl_df(mytbl)
Sys.setlocale("LC_TIME", "en_US.UTF-8") 
tbl3 <- tbl2 %>%
    select( Date, Time, Global_active_power ) %>%
    mutate( date = dmy(Date) + hms(Time), "GMT") %>%
    select(date,Global_active_power )

png(file = "plot2.png", width = 480, height = 480)

with( tbl3,{
    par(mar = c(4,4,4,2))
    plot(date, Global_active_power,type="l",  xlab="", ylab="Global Active Power(kilowatts)", ylim = range(Global_active_power)) 
})

dev.off()

