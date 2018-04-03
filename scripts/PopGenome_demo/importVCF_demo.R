library(PopGenome)
library(bigmemory)

setwd("/N/dc2/projects/PromoterPopGen/data/popgen_data/human/vcf_example")
GENOME.class <- readVCF(filename="ALL.chr22.1kGP.vcf.gz", numcols=2000, tid="22", frompos=1, topos=20000000)
get.sum.data(GENOME.class)
GENOME.class #shows the various options available to users