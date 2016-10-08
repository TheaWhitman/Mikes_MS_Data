# Network plot. 
network <- plot_net(biom, maxdist = 0.3, point_label = "SampleID.1", color = "Date", shape = "Site")
network
# Trees :)
biom.relabund.Methylococcaceae <- subset_taxa(biom.relabund, Family %in% "Methylococcaceae")
sample_data(biom.relabund.Methylococcaceae)$Date <- as.factor(sample_data(biom.relabund.Methylococcaceae)$Date)
biom.relabund.Methylococcaceae
head(tax_table(biom.relabund.Methylococcaceae))
tree1 <- plot_tree(biom.relabund.Methylococcaceae, color="Date", shape="Date", label.tips="Genus", size = "Abundance")
tree1
tree2 <- plot_tree(biom.relabund.Methylococcaceae, color="DateSite", label.tips = "Genus", size = "Abundance")
tree2