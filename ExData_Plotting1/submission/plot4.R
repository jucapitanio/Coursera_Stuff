# Downloading the file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
setInternet2(use = TRUE)
download.file(fileURL, destfile = "energy.zip") 

# Importing only the begining of the file, enough to contain 1/2/2007 and 2/2/2007.
energy <- read.table(unzip("energy.zip"), header = TRUE, sep=";", 
                     na.strings = "?", nrows = 70000) 

# Subsetting only the dates of interest.
energy$Date <- as.character(energy$Date)
energy$Time <- as.character(energy$Time)
energy2 <- subset(energy, Date == "1/2/2007" | Date == "2/2/2007") 

# Formatting the date and time objects.
dates <- energy2$Date
times <- energy2$Time
energy2$datetime <- paste(dates, times)
energy2$datetime <- strptime(energy2$datetime, "%d/%m/%Y %H:%M:%S", "CET")

# Creating the plots.
png(file = "plot4.png")
par(mfrow=c(2,2))

plot(energy2[,3], type = "l",xaxt = "n", main ="", ylab = 
         "Global Active Power (kilowatts)", xlab = "")
axis(1, at=c(1,1441,2881), labels=c("Thu","Fri","Sat"))

plot(energy2[,5], type = "l",xaxt = "n", main ="", ylab = 
         "Voltage", xlab = "datetime")
axis(1, at=c(1,1441,2881), labels=c("Thu","Fri","Sat"))

plot(energy2[,7], type = "l",xaxt = "n", main ="", ylab = 
         "Energy sub mettering", xlab = "", col = "black")
lines(x = rownames(energy2), y = energy2[,8], col = "red")
lines(x = rownames(energy2), y = energy2[,9], col = "blue")
axis(1, at=c(1,1441,2881), labels=c("Thu","Fri","Sat"))
legend("topright", col = c("black", "red", "blue"), lty=c(1,1),
       legend = colnames(energy2[,7:9]), bty="n")

plot(energy2[,4], type = "l",xaxt = "n", main ="", ylab = 
         "Global_reactive_power", xlab = "datetime")
axis(1, at=c(1,1441,2881), labels=c("Thu","Fri","Sat"))
dev.off()