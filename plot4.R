plot4 <- function() {
        ##plot chart plot4.png from data in working directory
        
        ##working directory contains the file "household_power_consumption.txt"
        ##read the file. use fast read of data.table. convert to data.frame.
        library(data.table) ##that package is required for reading large data faster
        powerData <- fread("household_power_consumption.txt", sep=";", colClasses="character") ##, nrows=howMany)  ##, skip=howManySkip)
        powerData <- powerData[as.character(powerData$Date)=="1/2/2007" | as.character(powerData$Date)=="2/2/2007"]
        powerData <- data.frame(powerData)
        ##convert relevant columns to numeric format
        powerData$Global_active_power <- as.numeric(powerData$Global_active_power)
        powerData$Sub_metering_1 <- as.numeric(powerData$Sub_metering_1)
        powerData$Sub_metering_2 <- as.numeric(powerData$Sub_metering_2)
        powerData$Sub_metering_3 <- as.numeric(powerData$Sub_metering_3)
        powerData$Voltage <- as.numeric(powerData$Voltage)
        powerData$Global_reactive_power <- as.numeric(powerData$Global_reactive_power)
        
        ##-----------------------------------
        ##store langugage settings, if computer setting is in foreign language:
           #user_lang <- Sys.getlocale("LC_TIME")
           #Sys.setlocale("LC_TIME", "English")
        ##-----------------------------------
        
        ##convert the dates to class date:
        powerData$DateTime <- paste(powerData$Date, powerData$Time, sep=" ")
        powerData$DateTime <- strptime(powerData$DateTime,"%d/%m/%Y %H:%M:%S")
        ##print chart plot4.png
        par(mar=c(4,5,4,1))
        par(mfrow=c(2,2))
        par(bg = "white")
        ##create the charts, one by one, write to file as set above
        with(powerData, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power", xlab=""))
        with(powerData, plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime"))
        with(powerData, plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab=""))
        lines(powerData$DateTime, powerData$Sub_metering_2, type="l", col="red")
        lines(powerData$DateTime, powerData$Sub_metering_3, type="l", col="blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c('black','red','blue'), lty=1,lwd=1.5)
        with(powerData, plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime"))
        dev.copy(png, file="plot4.png", width=480, height=480) ##print the graph from screen to png file
        dev.off() ##close device connection
        
        ##-----------------------------------
        ##restore foreign language:
           #Sys.setlocale("LC_TIME", user_lang)
        ##-----------------------------------
}