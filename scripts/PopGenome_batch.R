## This script in progress for testing on Carbonate
# must add routine to do with gff3 files
# current script will run, but encounters a 'segmentation fault' error

library(PopGenome)
library(bigmemory)
library(tools)

##########################################################################
#vcfDir <- "/N/dc2/projects/PromoterPopGen/human/human-split-data"	 
vcfDir <- "/N/dc2/projects/PromoterPopGen/Hs_split_data"
fileList <- "/N/dc2/projects/PromoterPopGen/human/human-split-data/human_file_list.txt"					 
file.names <- read.csv(file=fileList, header=FALSE)
colnames(file.names) <- c("chr", "start", "end", "file")		 
gffFile <- "/N/u/rtraborn/Carbonate/PromoterPopGen/annotation/Homo_sapiens.GRCh38.90.chromosome.7.gff3"
popListFile <- "/N/dc2/projects/PromoterPopGen/DmPromoterPopGen/data/human/pop_list_1kGP.csv"					 
##########################################################################

setwd(vcfDir)

source("/N/dc2/projects/PromoterPopGen/DmPromoterPopGen/scripts/identifiers_to_list.R")
pop.list <- identifiers_to_list(csv.file=popListFile)

for (i in 1:nrow(file.names)) {
    print(i)
    this.string <- file.names[i,]
    this.chr <- as.character(this.string[1])
    this.start <- this.string[2]
    	 if (this.start==0) {
	    this.start <- 1
	    }
    this.end <- this.string[3]
    this.filename <- as.character(unlist(this.string[4]))
    this.filename2 <- file_path_sans_ext(this.filename)
    diversity_out <- paste(this.filename2, "diversity", sep="_")
    diversity_filename <- paste(diversity_out, "txt", sep=".")    

    #for debugging
    #print(diversity_filename)
    #print(this.chr)
    #print(this.start)
    #print(this.end)
    #print(this.filename)

    GENOME.class <- readVCF(filename=this.filename, numcols=100000, frompos=this.start, topos=this.end, tid=this.chr, gffpath=gffFile)
    GENOME.class <- set.populations(GENOME.class, new.populations=pop.list, diploid=TRUE)  
    split <- split_data_into_GFF_features(GENOME.class, gff.file=gffFile, chr=this.chr, feature="gene")
    split <- diversity.stats(split, pi=FALSE, keep.site.info=TRUE)
    nuc.diversity.m <- split@nuc.diversity.within
    colnames(nuc.diversity.m) <- names(pop.list)
    write.table(nuc.diversity.m, col.names=TRUE, row.names=FALSE, sep="\t", file=diversity_filename) 

    #GENOME.class <- readVCF(filename=thisFileName, numcols=100000, frompos=this.start, topos=this.end, tid=this.chr, gffpath=gffFile)
    #GENOME.class <- set.populations(GENOME.class, new.populations=pop.list, diploid=TRUE)  
    #split <- split_data_into_GFF_features(GENOME.class, gff.file=gffFile, chr=this.chr, feature="gene")
    #split <- diversity.stats(split, pi=FALSE, keep.site.info=TRUE)
    #nuc.diversity.gene.m <- split@nuc.diversity.within
    #colnames(nuc.diversity.gene.m) <- names(pop.list)
    #write.table(nuc.diversity.gene.m, col.names=TRUE, row.names=FALSE, sep="\t", file="chr22_diversity_genes_test.txt")
}