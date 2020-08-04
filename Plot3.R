## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases
## in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

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

Emissions_year_point<- NEI %>% filter(fips=="24510", type=="POINT") %>% select(Emissions,year)
XY1<- as.data.frame(tapply(Emissions_year_point$Emissions, Emissions_year_point$year, sum))
XY1$year=c("1999","2002","2005","2008")
XY1$type=1
names(XY1)<- c("Total_PM2.5_Emission","Year","Type")
Emissions_year_nonpoint<- NEI %>% filter(fips=="24510", type=="NONPOINT") %>% select(Emissions,year)
XY2<- as.data.frame(tapply(Emissions_year_nonpoint$Emissions, Emissions_year_nonpoint$year, sum))
XY2$year=c("1999","2002","2005","2008")
XY2$type=2
names(XY2)<- c("Total_PM2.5_Emission","Year","Type")
Emissions_year_onroad<- NEI %>% filter(fips=="24510", type=="ON-ROAD") %>% select(Emissions,year)
XY3<- as.data.frame(tapply(Emissions_year_onroad$Emissions, Emissions_year_onroad$year, sum))
XY3$year=c("1999","2002","2005","2008")
XY3$type=3
names(XY3)<- c("Total_PM2.5_Emission","Year","Type")
Emissions_year_nonroad<- NEI %>% filter(fips=="24510", type=="NON-ROAD") %>% select(Emissions,year)
XY4<- as.data.frame(tapply(Emissions_year_nonroad$Emissions, Emissions_year_nonroad$year, sum))
XY4$year=c("1999","2002","2005","2008")
XY4$type=4
names(XY4)<- c("Total_PM2.5_Emission","Year","Type")
XY<- rbind(XY1,XY2,XY3,XY4)

g1<- ggplot(XY, aes(Year, Total_PM2.5_Emission)) + geom_point(aes(color=factor(Type)))
g2<- g1  + scale_color_discrete(name="Source", labels=c("Point","Non-Point","On-Road","Non-Road"))
g3<- g2 + labs(title="Emissions by Source for Baltimore City", x="Year", y="Total PM2.5 Emissions")


#Plot 3: Save histogram in png file
png(file="plot3.png", width = 480, height = 480)
plot(g3)
dev.off()