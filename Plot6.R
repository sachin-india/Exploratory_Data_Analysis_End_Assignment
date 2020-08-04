## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles
## County, California (fips == "06037"). Which city has seen greater changes over time
## in motor vehicle emissions?

library(ggplot2)
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

Emissions_year_BC<- NEI %>% filter(fips=="24510", type=="ON-ROAD") %>% select(Emissions,year)
XY1<- as.data.frame(tapply(Emissions_year_BC$Emissions, Emissions_year_BC$year, sum))
XY1$year=c("1999","2002","2005","2008")
XY1$region=1
names(XY1)<- c("Total_PM2.5_Emission","Year","Region")
Emissions_year_LAC<- NEI %>% filter(fips=="06037", type=="ON-ROAD") %>% select(Emissions,year)
XY2<- as.data.frame(tapply(Emissions_year_LAC$Emissions, Emissions_year_LAC$year, sum))
XY2$year=c("1999","2002","2005","2008")
XY2$region=2
names(XY2)<- c("Total_PM2.5_Emission","Year","Region")


XY<- rbind(XY1,XY2)

g1<- ggplot(XY, aes(Year, Total_PM2.5_Emission)) + geom_point(aes(shape=factor(Region)))
g2<- g1  + scale_shape_discrete(name="Region", labels=c("Baltimore City","Los Angeles County"))
g3<- g2 + labs(title="Motor Vehicle Emissions", x="Year", y="Total PM2.5 Emissions")


#Plot 6: Save histogram in png file
png(file="plot6.png", width = 480, height = 480)
plot(g3)
dev.off()