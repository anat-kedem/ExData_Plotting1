plot3 <- function() {
        ##plot chart plot3.png from data in working directory
        
        ##working directory contains the file "household_power_consumption.txt"
        ##read the file. use fast read of data.table. convert to data.fram.
        library(data.table) ##that package is required for reading large data fater
        powerData <- fread("household_power_consumption.txt", sep=";", colClasses="character") ##, nrows=howMany)  ##, skip=howManySkip)
        powerData <- powerData[as.character(powerData$Date)=="1/2/2007" | as.character(powerData$Date)=="2/2/2007"]
        powerData <- data.frame(powerData)
        ##convert columns of "Energy sub metering" to numeric format
        powerData$Sub_metering_1 <- as.numeric(powerData$Sub_metering_1)
        powerData$Sub_metering_2 <- as.numeric(powerData$Sub_metering_2)
        powerData$Sub_metering_3 <- as.numeric(powerData$Sub_metering_3)
        
        ##-----------------------------------
        ##store langugage settings, if computer setting is in foreign language:
        #user_lang <- Sys.getlocale("LC_TIME")
        #Sys.setlocale("LC_TIME", "English")
        ##-----------------------------------
        
        ##convert the dates to class date:
        powerData$DateTime <- paste(powerData$Date, powerData$Time, sep=" ")
        powerData$DateTime <- strptime(powerData$DateTime,"%d/%m/%Y %H:%M:%S")
        ##print chart plot3.png
        par(mar=c(4,5,1,1)) ##set margin
        png(file="plot3.png", width=480, height=480) ##set graphic device to png file
        ##create the chart with 3 lines, write to file as set above
        with(powerData, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
        lines(powerData$DateTime, powerData$Sub_metering_2, type="l", col="red")
        lines(powerData$DateTime, powerData$Sub_metering_3, type="l", col="blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c('black','red','blue'), lty=1,lwd=1.5) 
        dev.off() ##close device connection
        
        ##-----------------------------------
        ##restore foreign language:
        #Sys.setlocale("LC_TIME", user_lang)
        ##-----------------------------------
}