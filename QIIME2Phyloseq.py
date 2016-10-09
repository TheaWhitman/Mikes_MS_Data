
# coding: utf-8

# In[1]:

get_ipython().magic(u'matplotlib inline')
get_ipython().magic(u'load_ext rpy2.ipython')
# Loading matplot Python library
# Loading the Rmagic extension


# In[5]:

get_ipython().run_cell_magic(u'R', u'', u'#source(\'http://bioconductor.org/biocLite.R\')\n#biocLite(\'phyloseq\')\nlibrary(phyloseq)\nlibrary(ggplot2)\nlibrary(dplyr)\nlibrary(Rmisc)\nsetwd("~/Dropbox/clado-manuscript/Mikes_MS_Data/")')


# In[7]:

get_ipython().run_cell_magic(u'R', u'', u'# Load biom file and add metadata. \nbiom <- import_biom("OTU_table.biom", "~/Dropbox/clado-manuscript/Nephele/PipelineResults_NMEPINZ20QK1/nephele_outputs/tree.tre", parseFunction=parse_taxonomy_greengenes)\nsam.data <- read.csv(file="sample.data.csv", row.names=1, header=TRUE)\nhead(sam.data)\nsam.data$Date <- as.factor(sam.data$Date)\nsam.data$DateSite <- paste(sam.data$Date, sam.data$Site)\nhead(sam.data); str(sam.data)\nsample_data(biom) <- sam.data\nbiom; sample_data(biom)\nhead(otu_table(biom))')


# In[10]:

get_ipython().run_cell_magic(u'R', u'', u'# Custom plotting. \nnolegend <- theme(legend.position="none")\nreadabund <- labs(y="read abundance")\n# Normalize by relative abundance. \nbiom.relabund <- transform_sample_counts(biom, function(x) x / sum(x))\nordNMDS <- ordinate(biom.relabund, method="NMDS", distance="bray")\nordNMDS.k3 <- ordinate(biom.relabund, method="NMDS", distance="bray", k=3)\nord.k3 <- plot_ordination(biom.relabund, ordNMDS.k3, shape="Site", color = "DateSite") + geom_point(size=2) + geom_polygon(aes(fill=DateSite), alpha=0.7) + labs(title = "Cladophora, 2014") + theme_bw()\nord.k3\n# Facet by Date. \nord.k3.facet1 <- plot_ordination(biom.relabund, ordNMDS.k3, shape="Site", label = "Date") + geom_point(size=2.5) + facet_wrap(~Date) + labs(title = "Cladophora, 2014") + geom_polygon(aes(fill=DateSite)) + theme_bw()\nord.k3.facet1\n# Facet by Site. \nord.k3.facet2 <- plot_ordination(biom.relabund, ordNMDS.k3, label = "Date") + geom_point(size=2.5) + facet_wrap(~Site, ncol = 1) + labs(title = "Cladophora, 2014") + geom_polygon(aes(fill=DateSite)) + theme_bw()\nord.k3.facet2')


# In[16]:

get_ipython().run_cell_magic(u'R', u'', u'# Find methanotrophs\nmethanolist <- read.table(file = "/Users/michaeljbraus/Dropbox/clado-manuscript/clado_16S-archive/methanos.txt")\nmethanolist <- as.vector(methanolist$V1)\n# \nbiom.relabund.methanos <- subset_taxa(biom.relabund, Genus %in% as.factor(methanolist))\nbiom.relabund.methanos\nhead(tax_table(biom.relabund.methanos))\n# \nrelabund.methanos <- psmelt(biom.relabund.methanos)\nrelabund.methanos.genus <- relabund.methanos%>%\n  group_by(Sample, Genus)%>%\n  mutate(GenusAbundance = sum(Abundance))%>%\n  distinct(Sample, GenusAbundance, TreatmentGroup, Site, Date, Family, Genus)\nhead(relabund.methanos.genus)\n# \np <- ggplot(relabund.methanos.genus, aes(as.factor(Date), GenusAbundance, color = Site))\np <- p + geom_point() + facet_wrap(~Genus, scales="free_y")\np')


# In[14]:

get_ipython().run_cell_magic(u'R', u'', u'# Means with error bars\n# stats <- summarySE(biom, measurevar="Abundance", groupvars=c("bacsp","media")); stats\n# p.stats <- ggplot(stats, aes(x = media, y = percloss, fill = bacsp))\n# p.stats + geom_bar(stat = "identity", position=position_dodge(.9)) + geom_errorbar(aes(ymin=percloss-se, ymax=percloss+se), width=.2, colour="darkblue", position=position_dodge(.9)) + geom_rug()  + scale_fill_grey()')


# In[12]:

get_ipython().run_cell_magic(u'R', u'', u'# Plot richness. \nbiom.rich <- plot_richness(biom, x="Date", color="Site")\nbiom.rich')


# In[ ]:

get_ipython().run_cell_magic(u'R', u'', u'# Stacked bar plots of methanotrophs. \nbarstack.methanos <- plot_bar(biom.relabund.methanos, x = "Date", fill="Site") + facet_wrap(~Genus, scales="free_y")\nbarstack.methanos')

