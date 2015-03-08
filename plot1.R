# Plot 1
# load the needed libraries
library(dplyr)
library(lubridate)
library(sqldf)
library(tcltk)
library(datasets)

fl <- "household_power_consumption.txt"
mytbl <- read.csv2.sql(fl, sql =" select * from file where Date ='1/2/2007' OR Date ='2/2/2007'", header = TRUE, sep=";", dec="." )

tbl2 <- tbl_df(mytbl)
tbl2$Date <- dmy(tbl2$Date)
tbl2$Time <- hms(tbl2$Time)
tbl2$Global_active_power <- as.numeric(tbl2$Global_active_power)

# defining margins and plot a histogrtam as required in Plot 1
par(mar = c(10,8,8,20))
png(file = "plot1.png", width = 480, height = 480)
hist(tbl2$Global_active_power, breaks =seq(0,10, by = 0.5), col="red", xlim =range(0:6, asp=1), ylim= c(0,1200), xaxt="n", main = "Global Active Power", xlab= ("Global Active Power(kilowatts)"))
axis(1, at=c(0,2,4,6))
dev.off()
 
