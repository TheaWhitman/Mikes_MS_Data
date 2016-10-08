#source('http://bioconductor.org/biocLite.R')
#biocLite('phyloseq')
library(phyloseq)
library(ggplot2)
library(dplyr)
library(Rmisc)
setwd("~/Dropbox/clado-manuscript/Mikes_MS_Data/")
# Load biom file. 
biom <- import_biom("OTU_table.biom", "~/Dropbox/clado-manuscript/Nephele/PipelineResults_NMEPINZ20QK1/nephele_outputs/tree.tre", parseFunction=parse_taxonomy_greengenes)
sam.data <- read.csv(file="sample.data.csv", row.names=1, header=TRUE)
head(sam.data)
sam.data$Date <- as.factor(sam.data$Date)
sam.data$DateSite <- paste(sam.data$Date, sam.data$Site)
head(sam.data); str(sam.data)
sample_data(biom) <- sam.data
biom; sample_data(biom)
head(otu_table(biom))
# Custom plotting. 
nolegend <- theme(legend.position="none")
readabund <- labs(y="read abundance")
# Normalize by relative abundance. 
#pdf(file="figs/ord.k3.pdf", height=7, width=9)
biom.relabund <- transform_sample_counts(biom, function(x) x / sum(x))
ordNMDS <- ordinate(biom.relabund, method="NMDS", distance="bray")
ordNMDS.k3 <- ordinate(biom.relabund, method="NMDS", distance="bray", k=3)
ord.k3 <- plot_ordination(biom.relabund, ordNMDS.k3, shape="Site", color = "DateSite") + geom_point(size=2) + geom_polygon(aes(fill=DateSite), alpha=0.7) + labs(title = "Cladophora, 2014") + theme_bw()
ord.k3
#dev.off()
# Facet by Date. 
#pdf(file="figs/ord.k3.facet.date.pdf", height=6, width=10)
ord.k3.facet1 <- plot_ordination(biom.relabund, ordNMDS.k3, shape="Site", label = "Date") + geom_point(size=2.5) + facet_wrap(~Date) + labs(title = "Cladophora, 2014") + geom_polygon(aes(fill=DateSite)) + theme_bw()
ord.k3.facet1
#dev.off()
# Facet by Site. 
#pdf(file="figs/ord.k3.facet.site.pdf", height=8, width=6)
ord.k3.facet2 <- plot_ordination(biom.relabund, ordNMDS.k3, label = "Date") + geom_point(size=2.5) + facet_wrap(~Site, ncol = 1) + labs(title = "Cladophora, 2014") + geom_polygon(aes(fill=DateSite)) + theme_bw()
ord.k3.facet2
#dev.off()
# ANOSIM...
# Remove singleton. (EDA)
biom.nosingle <- prune_taxa(taxa_sums(biom)>1, biom)
biom.nosingle # Same, so QIIME QC covered it. 
# Find methanotrophs
methanolist <- read.table(file = "~/Dropbox/clado-manuscript/clado_16S-archive/methanos.txt")
methanolist <- as.vector(methanolist$V1)
# 
biom.relabund.methanos <- subset_taxa(biom.relabund, Genus %in% as.factor(methanolist))
biom.relabund.methanos
head(tax_table(biom.relabund.methanos))
# 
relabund.methanos <- psmelt(biom.relabund.methanos)
relabund.methanos.genus <- relabund.methanos%>%
  group_by(Sample, Genus)%>%
  mutate(GenusAbundance = sum(Abundance))%>%
  distinct(Sample, GenusAbundance, TreatmentGroup, Site, Date, Family, Genus)
head(relabund.methanos.genus)
# 
p <- ggplot(relabund.methanos.genus, aes(as.factor(Date), GenusAbundance, color = Site))
p <- p + geom_point() + facet_wrap(~Genus, scales="free_y")
#pdf(file="figs/methanos.relabund.pdf", height=8, width=15)
p
#dev.off()

# Means with error bars
stats <- summarySE(biom, measurevar="Abundance", groupvars=c("bacsp","media")); stats
p.stats <- ggplot(stats, aes(x = media, y = percloss, fill = bacsp))
p.stats + geom_bar(stat = "identity", position=position_dodge(.9)) + geom_errorbar(aes(ymin=percloss-se, ymax=percloss+se), width=.2, colour="darkblue", position=position_dodge(.9)) + geom_rug()  + scale_fill_grey()

# Plot richness. 
#pdf(file="figs/richness.pdf", height=8, width=20)
biom.rich <- plot_richness(biom, x="Date", color="Site")
biom.rich
#dev.off()

### Shannon linear model test. 
#biom.rich[1][1]

# Stacked bar plots of methanotrophs. 
rank_names(biom.relabund); sample_data(biom.relabund)
#pdf(file="figs/barstack.methanos.pdf", height=8, width=12)
barstack.methanos <- plot_bar(biom.relabund.methanos, x = "Date", fill="Site") + facet_wrap(~Genus, scales="free_y")
barstack.methanos
#dev.off()
# Network plot. 
#pdf(file="figs/network.pdf", height=8, width=12)
network <- plot_net(biom, maxdist = 0.3, point_label = "SampleID.1", color = "Date", shape = "Site")
network
#dev.off()
# Trees :)
#pdf(file="figs/Methylococcaceae.tree.site.pdf", height=8, width=10)
biom.relabund.Methylococcaceae <- subset_taxa(biom.relabund, Family %in% "Methylococcaceae")
sample_data(biom.relabund.Methylococcaceae)$Date <- as.factor(sample_data(biom.relabund.Methylococcaceae)$Date)
biom.relabund.Methylococcaceae
head(tax_table(biom.relabund.Methylococcaceae))
tree1 <- plot_tree(biom.relabund.Methylococcaceae, color="Date", shape="Date", label.tips="Genus", size = "Abundance")
tree1
#dev.off()
#pdf(file="figs/Methylococcaceae.tree.datesite.pdf", height=8, width=10)
tree2 <- plot_tree(biom.relabund.Methylococcaceae, color="DateSite", label.tips = "Genus", size = "Abundance")
tree2
#dev.off()

# Sandbox. 
