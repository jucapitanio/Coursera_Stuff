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

# Creating the histogram.
png(file = "plot1.png")
hist(energy2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()