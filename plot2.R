plot2 <- function() {
        ##plot chart plot2.png from data in working directory
        
        ##working directory contains the file "household_power_consumption.txt"
        ##read the file. use fast read of data.table. convert to data.fram.
        library(data.table) ##that package is required for reading large data fater
        powerData <- fread("household_power_consumption.txt", sep=";", colClasses="character") ##, nrows=howMany)  ##, skip=howManySkip)
        powerData <- powerData[as.character(powerData$Date)=="1/2/2007" | as.character(powerData$Date)=="2/2/2007"]
        powerData <- data.frame(powerData)
        ##convert column "Global Active Power" to numeric format
        powerData$Global_active_power <- as.numeric(powerData$Global_active_power)
        
        ##-----------------------------------
        #store langugage settings, if computer setting is in foreign language:
        #user_lang <- Sys.getlocale("LC_TIME")
        #Sys.setlocale("LC_TIME", "English")
        ##-----------------------------------
        
        ##convert the dates to class date:
        powerData$DateTime <- paste(powerData$Date, powerData$Time, sep=" ")
        powerData$DateTime <- strptime(powerData$DateTime,"%d/%m/%Y %H:%M:%S")
        ##print chart plot2.png
        par(mar=c(4,3,1,1)) ##set margin
        png(file="plot2.png", width=480, height=480) ##set graphic device to png file
        ##create the chart, write to file as set above
        with(powerData, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatt)", xlab=""))
        dev.off() ##close device connection
        
        ##-----------------------------------
        ##restore foreign language:
        #Sys.setlocale("LC_TIME", user_lang)
        ##-----------------------------------
}