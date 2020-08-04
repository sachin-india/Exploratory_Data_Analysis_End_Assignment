## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
## for each of the years 1999, 2002, 2005, and 2008

## Read source files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## fips: A five-digit number indicating the U.S. county
## SCC: The name of the source as indicated by a digit string
## Pollutant: A string indicating the pollutant
## Emissions: Amount of PM2.5 emitted, in tons
## type: The type of source (point, non-point, on-road, or non-road)
## year: The year of emissions recorded

Emissions_year<- NEI[,c("Emissions","year")]
XY<- tapply(Emissions_year$Emissions, Emissions_year$year, sum)


#Plot 1: Save histogram in png file
png(file="plot1.png", width = 480, height = 480)
barplot(XY, xlab = "Year", ylab = "Total PM2.5 emission", main = "USA")
dev.off()