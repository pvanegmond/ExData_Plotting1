##C4A1_Plot3.R
cat("\014 C4A1_Plot3.R\n") 

# 
# Data obtained from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 
#

dbug <- TRUE  # debug flag
if (dbug) {
  closeAllConnections()
  rm(list=ls())
} 

filePath <- file.path("./data", "C4A1") 

#We will only be using data from the dates 2007-02-01 and 2007-02-02.
startDate <- as.Date("1/2/2007", "%d/%m/%Y")
endDate   <- as.Date("2/2/2007" , "%d/%m/%Y")

## Now start the processing
#power <- read.table(file.path(filePath, "household_power_consumption.txt"),head=TRUE, sep=";", nrows=10000)
power <- read.table(file.path(filePath, "household_power_consumption.txt"),head=TRUE, sep=";")

#browser()

# Dates in the file is of the format "16/12/2006"
power$Date =  as.Date( power$Date , "%d/%m/%Y")

power$Global_active_power[power$Global_active_power=="?"] <- NA
power$Global_active_power = as.numeric( as.character( power$Global_active_power ) )
power$Sub_metering_1[power$Sub_metering_1=="?"] <- NA
power$Sub_metering_1 = as.numeric( as.character( power$Sub_metering_1 ) )
power$Sub_metering_2[power$Sub_metering_2=="?"] <- NA
power$Sub_metering_2 = as.numeric( as.character( power$Sub_metering_2 ) )
power$Sub_metering_3[power$Sub_metering_3=="?"] <- NA
power$Sub_metering_3 = as.numeric( as.character( power$Sub_metering_3 ) )


power1 = power[power$Date >= startDate & power$Date <= endDate,]
#power1 = power

power1$DateTime = paste( power1$Date, power1$Time )
power1$DateTime = strptime( power1$DateTime, "%Y-%m-%d %H:%M:%S" )

par( mfrow=c(1,1)) # Single plot1
#par( cex=.64 ) 

plot( power1$DateTime, power1$Sub_metering_1, xlab="", ylab="Energy sub metering", type = "n"   )
lines( power1$DateTime, power1$Sub_metering_1, type="l", col = "black" ) 
lines( power1$DateTime, power1$Sub_metering_2, type="l", col = "red" )
lines( power1$DateTime, power1$Sub_metering_3, type="l", col = "blue" )
legend("topright", lty=1, lwd=c(1,1,1), col=c( "Black", "Red","Blue"), legend =c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ), cex=.5 )

dev.copy( png, filename = "plot3.png", width=480, height=480 )
dev.off()


cat("C4A1_Plot3.R Finished\n") 
  