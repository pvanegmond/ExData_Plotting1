##C4A1_Plot1.R
cat("\014 C4A1_Plot1.R\n") 

# 
# Data obtained from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 
#

dbug <- TRUE  # debug flag
if (dbug) {
  closeAllConnections()
  rm(list=ls())
} 

#browser()
filePath <- file.path("./data", "C4A1") 

#We will only be using data from the dates 2007-02-01 and 2007-02-02.
startDate <- as.Date("1/2/2007", "%d/%m/%Y")
endDate   <- as.Date("2/2/2007" , "%d/%m/%Y")

## Now start the processing
#power <- read.table(file.path(filePath, "household_power_consumption.txt"),head=TRUE, sep=";", nrows=50000)
power <- read.table(file.path(filePath, "household_power_consumption.txt"),head=TRUE, sep=";")

# Dates in the file is of the format "16/12/2006"
power$Date =  as.Date( power$Date , "%d/%m/%Y")
power$Global_active_power[power$Global_active_power=="?"] <- NA
power$Global_active_power = as.numeric( as.character( power$Global_active_power ) )

power1 = power[power$Date >= startDate & power$Date <= endDate,]

par( mfrow=c(1,1)) # Single plot1
hist ( power1$Global_active_power, main="Global Active Power", xlab="Global Active Power (Kilowatts)", col="red")
#hist ( power1$Global_active_power, main="Global Active Power", xlab="Global Active Power (Kilowatts)", col="red")

dev.copy( png, filename = "plot1.png", width=480, height=480 )
dev.off()


cat("C4A1_Plot1.R Finished\n") 
  