library(dplyr)

## Estimating the required memory size
#The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).
no_columns <- 9
no_rows <- 2075259
bytes <- 8
gbtobyte <- 1073741824
reqMemorySizeGB <- no_columns * no_rows * bytes/gbtobyte
reqMemorySizeGB

## Load the data
# Note that in this dataset missing values are coded as ?.
dataFile = "./household_power_consumption.txt"
rawData <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?")

# check the data (2075259 observations)
head(rawData)
dim(rawData)
## Subset a data
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
allData <- mutate(rawData, Date = as.Date(Date, format("%d/%m/%Y")))
head(allData)

# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# (2880 observations)
selectedData <- filter(allData, format(allData$Date, "%Y-%m-%d") == "2007-02-01" | format(allData$Date, "%Y-%m-%d") == "2007-02-02")
head(selectedData)
tail(selectedData)
dim(selectedData)

# close all devices
dev.off(dev.list())

# plot 1 - a histogram
hist(selectedData$Global_active_power, main="Global Active Power", col="red")

# save the plot to png file
dev.copy(png, "plot1.png", width=480, height=480)

# close the device 
dev.off()
