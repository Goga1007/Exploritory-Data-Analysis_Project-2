# Exploratory Data Analysis/ Plot 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Loading provided datasets 
NEI <- readRDS("C:/Users/gogab/Documents/R Studio files/NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/gogab/Documents/R Studio files/NEI_data/Source_Classification_Code.rds")

# Sampling
NEI_sampling <- NEI[sample(nrow(NEI), size=5000, replace=F), ]

# Subset data two years in one data frame
MD <- subset(NEI, fips == '24510')

# Generate the graph 
png(filename = "C:/Users/gogab/Documents/R Studio files/EDA/Project 2/plot2.png")

barplot(tapply(X=MD$Emissions, INDEX=MD$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))

dev.off()
