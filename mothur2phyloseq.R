source("http://bioconductor.org/biocLite.R")
biocLite("phyloseq")
library(phyloseq)
#The following example assumes you have downloaded the esophagus example
#dataset from the mothur wiki:
#"http://www.mothur.org/wiki/Esophageal_community_analysis"
#"http://www.mothur.org/w/images/5/55/Esophagus.zip"
#The path on your machine may (probably will) vary
mothur_list_file  <- "~/Downloads/clado-mothur-phyloseq/clado.trim.contigs.subsample.good.unique.good.filter.unique.precluster.pick.pick.an.unique_list.list"
mothur_group_file <- "~/Downloads/clado-mothur-phyloseq/clado.contigs.subsample.good.groups"
mothur_tree_file  <- "~/Downloads/clado-mothur-phyloseq/clado.an.thetayc.0.03.lt.ave.tre"
show_mothur_cutoffs(mothur_list)
mothur_cutoff = "0.15"
test1 <- import_mothur(mothur_list_file, mothur_group_file, mothur_tree_file, mothur_cutoff)

plot_tree(test1, color="samples")