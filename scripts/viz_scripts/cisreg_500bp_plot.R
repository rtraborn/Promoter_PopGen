setwd("/N/u/rtraborn/Carbonate/PromoterPopGen/DmPromoterPopGen/Plots/")

library(ggplot2)
library(reshape2)
library(tools)

options(bitmapType='cairo')

dir.vec <- paste("cis", 1:22, sep="")
base.name <- "/N/dc2/projects/PromoterPopGen/Xuan/h_matrix/"
plot.name <- "pi_values_chr"

for (i in 1:length(dir.vec)) {
    print(i)
    this.ext <- dir.vec[i]
    my.path <- paste(base.name, this.ext, sep="")
    print(my.path)
    ma.files <- list.files(path=my.path, pattern="\\.txt", full.names=TRUE) 
    print(ma.files)
    #h.array <- matrix(NA, nrow=length(ma.files), ncol=501)
    h.list <- vector(mode="list", length=length(ma.files))
    #colnames(h.array) <- -250:250
    pop.names <- file_path_sans_ext(ma.files) 
    #rownames(h.array) <- pop.names
    names(h.list) <- pop.names
    #dim(h.array)
    for (j in ma.files) {
    	print(j)
	h_values <- read.table(file=j, header=FALSE)
	h.table <- h_values[,-1:-2]
	h.mean <- apply(h.table, 2, mean)
	print(length(h.mean))
	print(is(h.mean))
	h.list[[j]] <- as.matrix(h.mean)
	}

   h.out <- matrix(unlist(h.list), ncol = 501, byrow = TRUE)
   rownames(h.out) <- pop.names
   colnames(h.out) <- -250:250

   write.table(h.out, file="/N/u/rtraborn/Carbonate/PromoterPopGen/DmPromoterPopGen/scripts/viz_scripts/pi_values_chr22.txt", quote=F, row.names=TRUE, col.names=TRUE, sep="\t")

  h.mean.all <- apply(h.out, 2, mean)
  h.mean.df <- cbind(h.mean.all)
  rownames(h.mean.df) <- -250:250
  h.file <- paste(plot.name, i, sep="")
  h.final <- paste(h.file, "txt", sep=".")
  write.table(h.mean.all, file=h.final, quote=F, row.names=TRUE, col.names=FALSE, sep="\t")
  h.combined <- as.data.frame(cbind(-250:250, h.mean.all))
  colnames(h.combined) <- c("position","pi")
 
  plot.file <- paste(plot.name, i, sep="")
  plot.final <- paste(plot.file, "png", sep=".")
  p <- ggplot(h.combined, aes(x=position, y=pi))
  p + geom_point()

  ggsave(file=plot.final)
}

