
setwd("/N/dc2/projects/PromoterPopGen/Xuan/h_matrix/cis22/")    

library(ggplot2)
library(reshape2)
library(tools)

options(bitmapType='cairo')

ma.files <- list.files(path=".", pattern="\\.txt") 
#h.array <- matrix(NA, nrow=length(ma.files), ncol=501)
h.list <- vector(mode="list", length=length(ma.files))
#colnames(h.array) <- -250:250
pop.names <- file_path_sans_ext(ma.files) 
#rownames(h.array) <- pop.names
names(h.list) <- pop.names
#dim(h.array)
for (i in ma.files) {
    print(i)
    h_values <- read.table(file=i, header=FALSE)
    h.table <- h_values[,-1:-2]
    h.mean <- apply(h.table, 2, mean)
    print(length(h.mean))
    print(is(h.mean))
    h.list[[i]] <- as.matrix(h.mean)
}

h.out <- matrix(unlist(h.list), ncol = 501, byrow = TRUE)
rownames(h.out) <- pop.names
colnames(h.out) <- -250:250

write.table(h.out, file="/N/u/rtraborn/Carbonate/PromoterPopGen/DmPromoterPopGen/scripts/viz_scripts/pi_values_chr22.txt", quote=F, row.names=TRUE, col.names=TRUE, sep="\t")

h.melt <- melt(h.out)
colnames(h.melt) <- c("position","pi")
p <- ggplot(h.melt, aes(x=position, y=pi))
p + geom_point()

ggsave(file="/N/u/rtraborn/Carbonate/PromoterPopGen/DmPromoterPopGen/Plots/pi_chr22_500bp.png")

