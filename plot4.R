# PLot 4
# IMPORTANT NOTE: The data file ** "household_power_consumption.txt" **  must be present in the working directory

library(dplyr)
library(lubridate)
library(sqldf)
library(tcltk)
library(datasets)

# setting English names to dates
Sys.setlocale("LC_TIME", "en_US.UTF-8") 

# Reading partial table using sqldf's read.csv2.sql
fl <- "household_power_consumption.txt"
mytbl <- read.csv2.sql(fl, sql =" select * from file where Date ='1/2/2007' OR Date ='2/2/2007'", header = TRUE, sep=";", dec="." )

#converting to tbl-df
tbl2 <- tbl_df(mytbl)

#making a new table, by creating a combination of Date and Time  and Taking the rest from the parent table
tbl3 <- tbl2 %>%
   
    mutate( date = dmy(Date) + hms(Time), "GMT") %>%
    select(date,Global_active_power, Sub_metering_1, Sub_metering_2, Sub_metering_3, Voltage, Global_reactive_power )


#open png device
png(file = "plot4.png", width = 480, height = 480)


# creating the  4 line plots
>>>>>>> origin/master
with( tbl3,{
    par(mfrow = c(2, 2),mar = c(6,4,2,1)) # setting the device to 4 plots and appropiate margins
    # Plot1 top left
    plot(date, Global_active_power,type="l",  xlab="", ylab="Global Active Power(kilowatts)", ylim = range(Global_active_power)) 
    # plot 2, top right
    plot(date, Voltage,type="l", xlab="datetime", ylab="Voltage", ylim = range(Voltage) ) 
    
    # plot 3, bottom left
    plot(date, Sub_metering_1,type="l",  xlab="", ylab="Energy sub metering", ylim = range(Sub_metering_1), col ="black") 
    lines(date, Sub_metering_2,type="l",   col ="red") 
    lines(date, Sub_metering_3,type="l",  col = "blue") 
    legend("topright",   c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  col = c("black", "blue", "red"), lty=1, lwd=2, bty="n")
    
    # plot 4 bottom right
    plot(date, Global_reactive_power,type="l",  xlab="datetime",  ylab="Global_reactive_power", ylim = range(Global_reactive_power)) 
})

dev.off()
 
