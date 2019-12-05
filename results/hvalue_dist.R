#library(tidyverse)
library(ggplot2)

setwd("/N/dc2/projects/PromoterPopGen/hval_dist_analysis/PopGen_matrix_test/")

ma_file <- read.table(file="cis1/GBR.txt", header=FALSE)

ma_data <- ma_file[,-1:-2]
rownames(ma_data) <- ma_file[,2]
my.vec <- 0:40000
my.colnames <- paste("site",my.vec, sep="_")
colnames(ma_data) <- my.colnames

ma_data[1:10, 1:10]

all_data <- unlist(unclass(ma_data))

my.ind <- which(all_data>0)

all_data_plus <- all_data[my.ind]

save(all_data, file="all_hval_data.RData")
save(all_data_plus, file="all_hval_data_plus.RData")