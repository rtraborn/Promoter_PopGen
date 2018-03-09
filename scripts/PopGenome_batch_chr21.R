## This script tested and ready for production mode on Carbonate

library(PopGenome)
library(bigmemory)
library(tools)

##########################################################################
vcfDir <- "/N/dc2/projects/PromoterPopGen/human/human-split-data"	 
fileList <- "/N/dc2/projects/PromoterPopGen/human/human-split-data/human_file_list_21.txt"					 
file.names <- read.csv(file=fileList, header=FALSE)
colnames(file.names) <- c("chr", "start", "end", "file")		 
gffFile <- "/N/dc2/projects/PromoterPopGen/genes_gff/Homo_sapiens.GRCh38.90.chromosome.21.gff3"
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
    gc()
    split <- diversity.stats(split, pi=TRUE, keep.site.info=TRUE)
    feature.names <- split@region.names
    n.features <- length(split@region.names)
    nuc.diversity.m <- split@nuc.diversity.within
    colnames(nuc.diversity.m) <- names(pop.list)
    write.table(nuc.diversity.m, col.names=TRUE, row.names=FALSE, sep="\t", file=diversity_filename) 
         for (i in 1:n.features) {
	        print(i)
	        f.name <- feature.names[i]
	        root.name <- paste(f.name, "chr", this.chr, sep="_")
		fileName <- paste(root.name, "txt", sep=".")
		pi.ma <- split@region.stats@nuc.diversity.within[[i]]
		if (is.null(pi.ma)==FALSE) {
				pi.ma.t <- t(pi.ma)
				colnames(pi.ma.t) <- names(pop.list)
				write.table(pi.ma.t, col.names=TRUE, row.names=TRUE, sep="\t", quote=FALSE, file=fileName)
				}
		else { print("No variation in feature.") 
			}
    }
    gc()
}