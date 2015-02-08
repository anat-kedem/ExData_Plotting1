plot1 <- function() {
##plot chart plot1.png from data in working directory
        
        ##working directory contains the file "household_power_consumption.txt"
        ##read the file. use fast read of data.table. convert to data.fram.
        library(data.table) ##that package is required for reading large data fater
        powerData <- fread("household_power_consumption.txt", sep=";", colClasses="character") ##, nrows=howMany)  ##, skip=howManySkip)
        powerData <- powerData[as.character(powerData$Date)=="1/2/2007" | as.character(powerData$Date)=="2/2/2007"]
        powerData <- data.frame(powerData)
        ##convert column "Global Active Power" to numeric format
        powerData$Global_active_power <- as.numeric(powerData$Global_active_power)
        ##print chart plot1.png
        par(mar=c(5,5,5,5)) ##set margin
        png(file="plot1.png", width=480, height=480) ##set graphic device to png file
        ##create the chart, write to file as set above
        hist(powerData$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatt)", ylab="Frequency")
        dev.off() ##close device connection
}