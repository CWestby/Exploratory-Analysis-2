library(dplyr)
library(ggplot2)

url <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                     destfile = "Emissions Data.zip")
file <- unzip("Emissions Data.zip")
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

PM25_Baltimore_types <- PM25 %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarize(total = sum(Emissions))


ggplot(PM25_Baltimore_types, aes(x = year, y = total, col = type)) +
  geom_line() +
  labs(x = "Year", y = "Total Emissions", 
       title = "Total Baltimore Emissions by Type")