library(ggplot2)
library(grid)
library(gridExtra)
setwd("~/Dropbox/clado-manuscript/Mikes_MS_Data/")
data <- read.csv("north_temperate_lakes_lter__daily_water_temperature_-_lake_mendota.csv", header=T)
head(data)
nolegend <- theme(legend.position="none")
Jdays <- c(172,178,185,199,206,214)
# Subset all wtemp at or below 1.5 meters (sample depth up to shore). 
clado.depth <- subset(data, depth<=1.5, select = year4:wtemp)
# All years (2006-2016), full year. 
wide1 <- qplot(clado.depth$daynum, y = clado.depth$wtemp) + 
  geom_point(aes(colour = clado.depth$year4), size=2) + 
  labs(title = "Water Temperature at or below 1.5m, Full Year", x="Julian Day", y="Temperature °C") + 
  geom_vline(xintercept=Jdays, colour="darkgreen", linetype = "longdash") + 
  guides(color=guide_legend(title="Year")) + 
  scale_colour_gradient(low = "darkred")
wide1
# All years (2006-2016), sample dates ± 25 days
clado.depth.zoom <- subset(clado.depth, daynum>=150 & daynum<=250, select = year4:wtemp)
zoom1 <- qplot(clado.depth.zoom$daynum, y = clado.depth.zoom$wtemp) + 
  geom_point(aes(colour = clado.depth.zoom$year4), size=2) + 
  labs(title = "Water Temperature at or below1.5m, JDays 150 to 250", x="julian day", y="temperature °C") + 
  geom_vline(xintercept=Jdays, colour="darkgreen", linetype = "longdash") + 
  guides(color=guide_legend(title="year")) + scale_colour_gradient(low = "darkred")
zoom1
# Smarter way to make grid of plots. 
#pdf(file="figs/wtemp_lowdepth_grid.pdf", height=6, width=10)
p <- ggplot(clado.depth.zoom, aes(daynum, wtemp))
p <- p + geom_point() + ylim(15,30) + facet_wrap(~year4) + geom_vline(xintercept=Jdays, colour="grey30", linetype = "longdash") + guides(color=guide_legend(title="Year"))
p
#dev.off()
