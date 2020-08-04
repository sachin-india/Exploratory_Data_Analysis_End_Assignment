## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510")
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

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

Emissions_year<- NEI %>% filter(fips=="24510") %>% select(Emissions,year)
XY<- tapply(Emissions_year$Emissions, Emissions_year$year, sum)


#Plot 2: Save histogram in png file
png(file="plot2.png", width = 480, height = 480)
barplot(XY, xlab = "Year", ylab = "Total PM2.5 emission", main = "Baltimore City")
dev.off()