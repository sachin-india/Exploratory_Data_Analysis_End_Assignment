## Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(data.table)
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

SCC_coal<- SCC[SCC$Short.Name %like% "Coal" | SCC$Short.Name %like% "coal" | SCC$EI.Sector %like% "Coal",]
NEI_coal<- merge(NEI, SCC_coal, by="SCC")


Emissions_year_coal<- NEI_coal %>% select(Emissions,year)
XY<- tapply(Emissions_year_coal$Emissions, Emissions_year_coal$year, sum)


#Plot 4: Save histogram in png file
png(file="plot4.png", width = 480, height = 480)
barplot(XY, xlab = "Year", ylab = "Total PM2.5 emission", main = "Coal emissions for United States")
dev.off()