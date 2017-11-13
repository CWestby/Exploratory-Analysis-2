library(dplyr)
library(ggplot2)

url <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                     destfile = "Emissions Data.zip")
file <- unzip("Emissions Data.zip")
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_mobile <- SCC %>%
  filter(SCC.Level.One == "Mobile Sources")

PM25_Baltimore_motor_total <- PM25 %>%
  filter(fips == "24510" & SCC %in% SCC_mobile$SCC) %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

plot <- plot(PM25_Baltimore_motor_total$year, PM25_Baltimore_motor_total$total, 
     type = "l", xlab = "Year", ylab = "Total Emissions", 
     main = "Baltimore Motor Vehicle Emissions by Year")

  