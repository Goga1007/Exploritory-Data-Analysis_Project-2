# Exploratory Data Analysis/ Plot 6

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time 
# in motor vehicle emissions?

library(ggplot2)

NEI <- readRDS("C:/Users/gogab/Documents/R Studio files/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/gogab/Documents/R Studio files/NEI_data/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland
# Los Angeles County, California
MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate
MD.DF <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.DF) <- c('year', 'Emissions')
MD.DF$City <- paste(rep('MD', 4))

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum)
colnames(CA.DF) <- c('year', 'Emissions')
CA.DF$City <- paste(rep('CA', 4))

DF <- as.data.frame(rbind(MD.DF, CA.DF))

# Generate the graph 
png(filename = "C:/Users/gogab/Documents/R Studio files/EDA/Project 2/plot6.png", width = 500,height = 500,units = "px",bg ="transparent")

ggplot(data = DF, aes(x = factor(year), y = Emissions, fill = City)) +
  geom_bar(aes(fill = year),stat = "identity") +
  facet_grid(.~City) +
  guides(fill = FALSE) + theme_bw() +
  labs(x = "year", y = expression("PM"[2.5])) + 
  labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()
