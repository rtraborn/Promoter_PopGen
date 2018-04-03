library(PopGenome)
library(bigmemory)
source("id_to_list.R")
pop.list <- identifiers_to_list(csv.file="pop_list_1kGP.csv")

GENOME.class <- readVCF(filename="ALL.chr22.1kGP.vcf.gz", numcols=100000, frompos=1, topos=20000000, tid="22", gffpath="hg19.cage_peak_phase1and2combined_coord_chr22_reheader.gff3")
GENOME.class <- set.populations(GENOME.class, new.populations=pop.list, diploid=TRUE)  
split <- split_data_into_GFF_features(GENOME.class, gff.file="hg19.cage_peak_phase1and2combined_coord_chr22_reheader.gff3", chr="22", feature="sequence_feature")
split <- diversity.stats(split, pi=TRUE, keep.site.info=TRUE)
nuc.diversity.m <- split@nuc.diversity.within
colnames(nuc.diversity.m) <- names(pop.list)
write.table(nuc.diversity.m, col.names=TRUE, row.names=FALSE, sep="\t", file="chr22_diversity_reg_test.txt") 

GENOME.class <- readVCF(filename="ALL.chr22.1kGP.vcf.gz", numcols=100000, frompos=1, topos=20000000, tid="22", gffpath="Homo_sapiens.GRCh38.90.chromosome.22.gff3")
GENOME.class <- set.populations(GENOME.class, new.populations=pop.list, diploid=TRUE)  
split <- split_data_into_GFF_features(GENOME.class, gff.file="Homo_sapiens.GRCh38.90.chromosome.22.gff3", chr="22", feature="gene")
split <- diversity.stats(split, pi=TRUE, keep.site.info=TRUE)
nuc.diversity.gene.m <- split@nuc.diversity.within
colnames(nuc.diversity.gene.m) <- names(pop.list)
write.table(nuc.diversity.gene.m, col.names=TRUE, row.names=FALSE, sep="\t", file="chr22_diversity_genes_test.txt")