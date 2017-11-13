library(dplyr)

url <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                     destfile = "Emissions Data.zip")
file <- unzip("Emissions Data.zip")
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

PM25_Baltimore <- filter(PM25, fips == "24510")
PM25_Baltimore_total <- PM25_Baltimore %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

plot(PM25_Baltimore_total$year, PM25_Baltimore_total$total, type = "l",
     xlab = "Year", ylab = "Total Emissions", 
     main = "Total Emissions by Year: Baltimore")