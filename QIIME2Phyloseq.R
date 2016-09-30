#source('http://bioconductor.org/biocLite.R')
#biocLite('phyloseq')
library(phyloseq)
library(ggplot2)
library(dplyr)
setwd("~/Dropbox/Mikes_MS_Data/")
# Load biom file. 
biom <- import_biom("OTU_table.biom", parseFunction=parse_taxonomy_greengenes); head(biom)
sam.data <- read.csv(file="sample.data.csv", row.names=1, header=TRUE)
head(sam.data)
sample_data(biom) <- sam.data 
biom; head(otu_table(biom))
# Normalize by relative abundance. 
biom.relabund <- transform_sample_counts(biom, function(x) x / sum(x))
ordNMDS <- ordinate(biom.relabund, method="NMDS", distance="bray")
# Run 20 stress 0.1164499 
ordNMDS.k3 <- ordinate(biom.relabund, method="NMDS", distance="bray", k=3)
# Run 20 stress 0.08334116 
ord.k3 <- plot_ordination(biom.relabund, ordNMDS.k3, shape="SampleSite", color="Date", label = "Date") + 
  geom_point(size=4) + 
  facet_wrap(~SampleSite) + 
  labs(title = "Cladophora, 2014")
pdf(file="figs/ord.k3.pdf", height=6, width=15)
ord.k3; dev.off()
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
  distinct(Sample, GenusAbundance, TreatmentGroup, SampleSite, Date, Family, Genus)
head(relabund.methanos.genus)
# 
p <- ggplot(relabund.methanos.genus, aes(Date, GenusAbundance, color = SampleSite))
p <- p + geom_boxplot() + facet_wrap(~Genus, scales="free_y")
pdf(file="figs/methanos.relabund.pdf", height=8, width=15)
p; dev.off()
