library(dplyr)

url <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
              destfile = "Emissions Data.zip")
file <- unzip("Emissions Data.zip")
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
PM25_total <- PM25 %>%
  group_by(year) %>%
  summarize(sum = sum(Emissions))

plot(PM25_total$year, PM25_total$sum, type = "l", 
     xlab = "Year", ylab = "Total Emission", main = "Total Emissions by Year")