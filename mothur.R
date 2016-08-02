setwd("~/.../clado...")

# Rarefaction curve
data<-read.table(file="clado.unique.filter.fn.FS396.rarefaction", header=T)
plot(x=data$numsampled, y=data$unique, xlab="Number of Tags Sampled",ylab="OTUs", type="l", col="black", font.lab=3)
points(x=data$numsampled, y=data$X0.03, type="l", col="blue")
points(x=data$numsampled, y=data$X0.05, type="l", col="red")
points(x=data$numsampled, y=data$X0.10, type="l", col="green")
legend(x=50000, y=1500, c("unique", "0.03", "0.05", "0.10"), c("black", "blue", "red", "green"))
