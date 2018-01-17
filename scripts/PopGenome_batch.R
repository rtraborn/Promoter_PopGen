## This script in progress for testing on Carbonate
#must install package 'ff' prior to installing PopGenome on the system
library(PopGenome)
library(bigmemory)
library(tools)

source("id_to_list.R")

##########################################################################
vcfDir <- "/N/dc2/projects/PromoterPopGen/human/human-split-data"	 #
fileList <- "human_file_list.txt"					 #
file.names <- read.csv(file=fileList, header=FALSE)			 #
colnames(file.names) <- c("chr", "start", "end", "file")		 #
gffFile <- "hg19.cage_peak_phase1and2combined_coord_chr22_reheader.gff3" #
popListFile <- "pop_list_1kGP.csv"					 #
##########################################################################

setwd(vcfDir)
pop.list <- identifiers_to_list(csv.file=popListFile)

for (i in 1:nrow(file.names)) {
    this.string <- file.names[i,]
    this.chr <- as.character(this.string[1])
    this.start <- this.string[2]
    this.end <- this.string[3]
    this.filename <- as.character(this.string[4])
    this.filename2 <- file_path_sans_ext(this.filename)
    diversity_out <- paste(this.filename2, "diversity", sep="_")
    diversity_filename <- paste(diversity_out, "txt", sep=".")    

    print(diversity_filename)
    print(this.chr)
    print(this.start)
    print(this.end)
    print(this.filename)

    #GENOME.class <- readVCF(filename=thisFileName, numcols=100000, frompos=this.start, topos=this.end, tid=this.chr, gffpath=gffFile)
    #GENOME.class <- set.populations(GENOME.class, new.populations=pop.list, diploid=TRUE)  
    #split <- split_data_into_GFF_features(GENOME.class, gff.file=gffFile, chr=this.chr, feature="sequence_feature")
    #split <- diversity.stats(split, pi=TRUE, keep.site.info=TRUE)
    #nuc.diversity.m <- split@nuc.diversity.within
    #colnames(nuc.diversity.m) <- names(pop.list)
    #write.table(nuc.diversity.m, col.names=TRUE, row.names=FALSE, sep="\t", file=diversity_filename) 

    #GENOME.class <- readVCF(filename=thisFileName, numcols=100000, frompos=this.start, topos=this.end, tid=this.chr, gffpath=gffFile)
    #GENOME.class <- set.populations(GENOME.class, new.populations=pop.list, diploid=TRUE)  
    #split <- split_data_into_GFF_features(GENOME.class, gff.file=gffFile, chr=this.chr, feature="gene")
    #split <- diversity.stats(split, pi=TRUE, keep.site.info=TRUE)
    #nuc.diversity.gene.m <- split@nuc.diversity.within
    #colnames(nuc.diversity.gene.m) <- names(pop.list)
    #write.table(nuc.diversity.gene.m, col.names=TRUE, row.names=FALSE, sep="\t", file="chr22_diversity_genes_test.txt")
}