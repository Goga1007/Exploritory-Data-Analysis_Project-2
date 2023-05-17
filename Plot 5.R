# Exploratory Data Analysis/ Plot 5
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

library(ggplot2)

# Loading datasets 
NEI <- readRDS("C:/Users/gogab/Documents/R Studio files/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/gogab/Documents/R Studio files/NEI_data/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland == fips
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
MD.df <- aggregate(MD.onroad[, 'Emissions'], by = list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

# Generate the graph in the same directory as the source code
png(filename = "C:/Users/gogab/Documents/R Studio files/EDA/Project 2/plot5.png", width=480,height=480,units="px",bg="transparent")

ggplot(data = MD.df, aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill = "grey", width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x = "year", y = expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()
