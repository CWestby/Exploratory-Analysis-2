library(dplyr)
library(ggplot2)

url <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                     destfile = "Emissions Data.zip")
file <- unzip("Emissions Data.zip")
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_coal_combustion <- SCC %>%
  filter(SCC.Level.One == "External Combustion Boilers" |
           SCC.Level.One == "Internal Combustion Engines") %>%
  filter(SCC.Level.Three == "Anthracite Coal" 
         | SCC.Level.Three == "Pulverized Coal"
         | SCC.Level.Four == "Anthracite Coal"
         | SCC.Level.Four == "Anthracite Coal")

PM25_coal_combustion_total <- PM25 %>%
  filter(SCC %in% SCC_coal_combustion$SCC) %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

plot(PM25_coal_combustion_total$year, PM25_coal_combustion_total$total, 
     type = "l", xlab = "Year", ylab = "Total Emissions",
     main = "Coal Combustion Emissions by Year")
