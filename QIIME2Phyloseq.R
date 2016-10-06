#source('http://bioconductor.org/biocLite.R')
#biocLite('phyloseq')
library(phyloseq)
library(ggplot2)
library(dplyr)
setwd("~/Dropbox/clado-manuscript/Mikes_MS_Data/")
# Load biom file. 
biom <- import_biom("OTU_table.biom", parseFunction=parse_taxonomy_greengenes)
sam.data <- read.csv(file="sample.data.csv", row.names=1, header=TRUE)
head(sam.data)
sam.data$DateSite <- paste(sam.data$Date, sam.data$Site)
head(sam.data)
sample_data(biom) <- sam.data 
biom; sample_data(biom)
head(otu_table(biom))
# Custom plotting. 
nolegend <- theme(legend.position="none")
readabund <- labs(y="read abundance")
# Normalize by relative abundance. 
biom.relabund <- transform_sample_counts(biom, function(x) x / sum(x))
ordNMDS <- ordinate(biom.relabund, method="NMDS", distance="bray")
ordNMDS.k3 <- ordinate(biom.relabund, method="NMDS", distance="bray", k=3)
ord.k3 <- plot_ordination(biom.relabund, ordNMDS.k3, label="Date", shape="Site") + geom_point(size=2.5) + geom_polygon(aes(fill=DateSite)) + scale_color_gradient(low = "grey")
#pdf(file="figs/ord.k3.pdf", height=7, width=9)
ord.k3
#dev.off()
ord.k3.facet <- plot_ordination(biom.relabund, ordNMDS.k3, shape="Site", color="Date", label = "Date") + geom_point(size=4) + facet_wrap(~Site) + labs(title = "Cladophora, 2014")
#pdf(file="figs/ord.k3.facet.pdf", height=6, width=15)
ord.k3.facet
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
p <- ggplot(relabund.methanos.genus, aes(Date, GenusAbundance, color = Site))
p <- p + geom_boxplot() + facet_wrap(~Genus, scales="free_y")
#pdf(file="figs/methanos.relabund.pdf", height=8, width=15)
p
#dev.off()
# Plot richness. 
#pdf(file="figs/richness.pdf", height=8, width=20)
biom.rich <- plot_richness(biom, x="Date", color="Site")
biom.rich
#dev.off()
# Bar plots.

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