## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(dplyr)

## Read source files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## fips: A five-digit number indicating the U.S. county
## SCC: The name of the source as indicated by a digit string
## Pollutant: A string indicating the pollutant
## Emissions: Amount of PM2.5 emitted, in tons
## type: The type of source (point, non-point, on-road, or non-road)
## year: The year of emissions recorded

Emissions_year<- NEI %>% filter(fips=="24510", type=="ON-ROAD") %>% select(Emissions,year)
XY<- tapply(Emissions_year$Emissions, Emissions_year$year, sum)


#Plot 5: Save histogram in png file
png(file="plot5.png", width = 480, height = 480)
barplot(XY, xlab = "Year", ylab = "Total PM2.5 emission", main = "Motor Vehicle Emissions for Baltimore City")
dev.off()