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

# Identifying days of the week and row numbers where they change
energy2$dayofweek <- weekdays(energy2[,10])
rownames(energy2) <- as.numeric(1:2880)
head(energy2[energy2$Date == "2/2/2007",],1)

# Creating the line plot.
png(file = "plot3.png")
plot(energy2[,7], type = "l",xaxt = "n", main ="", ylab = 
         "Energy sub mettering", xlab = "", col = "black")
lines(x = rownames(energy2), y = energy2[,8], col = "red")
lines(x = rownames(energy2), y = energy2[,9], col = "blue")
axis(1, at=c(1,1441,2881), labels=c("Thu","Fri","Sat"))
legend("topright", col = c("black", "red", "blue"), lty=c(1,1),
       legend = colnames(energy2[,7:9]),)
dev.off()