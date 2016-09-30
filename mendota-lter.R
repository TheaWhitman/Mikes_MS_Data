library(ggplot2)
library(grid)
library(gridExtra)
setwd("~/Dropbox/Mikes_MS_Data/")
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
# 2011
clado.depth.zoom.eleven <- subset(clado.depth, daynum>=150 & daynum<=250 & year4==2011, select = year4:wtemp)
eleven <- qplot(clado.depth.zoom.eleven$daynum, y = clado.depth.zoom.eleven$wtemp) + 
  geom_point(aes(colour = clado.depth.zoom.eleven$year4), size=2) + 
  labs(title = "Water Temperature at or below1.5m, 2011", x="julian day", y="temperature °C") + 
  geom_vline(xintercept=Jdays, colour="darkgrey", linetype = "longdash") + 
  guides(color=guide_legend(title="year")) + scale_colour_gradient(low = "black") + 
  nolegend
eleven
# 2012
clado.depth.zoom.twelve <- subset(clado.depth, daynum>=150 & daynum<=250 & year4==2012, select = year4:wtemp)
twelve <- qplot(clado.depth.zoom.twelve$daynum, y = clado.depth.zoom.twelve$wtemp) + geom_point(aes(colour = clado.depth.zoom.twelve$year4), size=2) + labs(title = "Water Temperature at or below1.5m, 2012", x="julian day", y="temperature °C") + geom_vline(xintercept=Jdays, colour="darkgrey", linetype = "longdash") + guides(color=guide_legend(title="year")) + scale_colour_gradient(low = "black") + nolegend
twelve
# 2013
clado.depth.zoom.thirteen <- subset(clado.depth, daynum>=150 & daynum<=250 & year4==2013, select = year4:wtemp)
thirteen <- qplot(clado.depth.zoom.thirteen$daynum, y = clado.depth.zoom.thirteen$wtemp) + geom_point(aes(colour = clado.depth.zoom.thirteen$year4), size=2) + labs(title = "Water Temperature at or below1.5m, 2013", x="julian day", y="temperature °C") + geom_vline(xintercept=Jdays, colour="darkgrey", linetype = "longdash") + guides(color=guide_legend(title="year")) + scale_colour_gradient(low = "black") + nolegend
thirteen
# 2014
clado.depth.zoom.fourteen <- subset(clado.depth, daynum>=150 & daynum<=250 & year4==2014, select = year4:wtemp)
fourteen <- qplot(clado.depth.zoom.fourteen$daynum, y = clado.depth.zoom.fourteen$wtemp) + geom_point(aes(colour = clado.depth.zoom.fourteen$year4), size=2) + labs(title = "Water Temperature at or below1.5m, 2014", x="julian day", y="temperature °C") + geom_vline(xintercept=Jdays, colour="darkgrey", linetype = "longdash") + guides(color=guide_legend(title="year")) + scale_colour_gradient(low = "black") + nolegend
fourteen
# 2015
clado.depth.zoom.fifteen <- subset(clado.depth, daynum>=150 & daynum<=250 & year4==2015, select = year4:wtemp)
fifteen <- qplot(clado.depth.zoom.fifteen$daynum, y = clado.depth.zoom.fifteen$wtemp) + geom_point(aes(colour = clado.depth.zoom.fifteen$year4), size=2) + labs(title = "Water Temperature at or below1.5m, 2015", x="julian day", y="temperature °C") + geom_vline(xintercept=Jdays, colour="darkgrey", linetype = "longdash") + guides(color=guide_legend(title="year")) + scale_colour_gradient(low = "black") + nolegend
fifteen
# 2016
clado.depth.zoom.sixteen <- subset(clado.depth, daynum>=150 & daynum<=250 & year4==2016, select = year4:wtemp)
sixteen <- qplot(clado.depth.zoom.sixteen$daynum, y = clado.depth.zoom.sixteen$wtemp) + geom_point(aes(colour = clado.depth.zoom.sixteen$year4), size=2) + labs(title = "Water Temperature at or below1.5m, 2016", x="julian day", y="temperature °C") + geom_vline(xintercept=Jdays, colour="darkgrey", linetype = "longdash") + guides(color=guide_legend(title="year")) + scale_colour_gradient(low = "black") + nolegend
sixteen
# All plots in grid. 
#pdf(file="figs/wtemp_alldepths_2011-16.pdf", height=8, width=15)
allplots <- grid.arrange(eleven,twelve,thirteen,fourteen,fifteen,sixteen, ncol=3)
allplots
#dev.off()
