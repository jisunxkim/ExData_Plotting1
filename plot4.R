library(dplyr)

## Load the data
# Note that in this dataset missing values are coded as ?.
dataFile = "./household_power_consumption.txt"
rawData <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?")

# check the data (2075259 observations)
head(rawData)

# Combine Date and Time into Date_Time variable 
allData <- mutate(rawData, Date_Time = paste(Date, Time))

# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
allData2 <- mutate(allData, 
                  Date_Time = as.POSIXct(
                          strptime(Date_Time, "%d/%m/%Y %H:%M:%S")
                          )
                  )

head(allData2)

# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# (2880 observations)
selectedData <- filter(allData2, format(allData2$Date_Time, "%Y-%m-%d") == "2007-02-01" | format(allData2$Date_Time, "%Y-%m-%d") == "2007-02-02")
head(selectedData)
tail(selectedData)
dim(selectedData)
summary(selectedData)

# close all devices
dev.off(dev.list())

# plot 4 - multi time series charts
attach(selectedData)
par(mfrow=c(2,2))


plot(Sub_metering_1 ~ Date_Time, ylab = "Energy sub metering", xlab="", type="n")

lines(Date_Time, Sub_metering_1)
lines(Date_Time, Sub_metering_2, col="red")
lines(Date_Time, Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

# save the plot to png file
dev.copy(png, "plot3.png", width=480, height=480)

# close the device 
dev.off()
