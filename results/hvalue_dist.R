library(ggplot2)

setwd("/N/dc2/projects/PromoterPopGen/PromoterPopGen/results")

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

hval.plus <- as.data.frame(cbind(all_data_plus))
n.row.vec <- 1:nrow(hval.plus)

hval.plus.df <-  cbind(hval.plus, n.row.vec)
head(hval.plus.df)

quantile(hval.plus.df$all_data_plus, probs= seq(0, 1, 0.1), na.rm=FALSE)

a <- ggplot(hval.plus.df, aes(all_data_plus))
a + geom_histogram(binwidth = 0.01, col="white", fill="royalblue") 

ggsave(file="h_val_dist_GBR.png")

ma_file <- read.table(file="cis1/FIN.txt", header=FALSE)

ma_data <- ma_file[,-1:-2]
rownames(ma_data) <- ma_file[,2]
my.vec <- 0:40000
my.colnames <- paste("site",my.vec, sep="_")
colnames(ma_data) <- my.colnames

ma_data[1:10, 1:10]

all_data <- unlist(unclass(ma_data))

my.ind <- which(all_data>0)

all_data_plus <- all_data[my.ind]

save(all_data, file="all_hval_data_FIN.RData")
save(all_data_plus, file="all_hval_data_plus_FIN.RData")

hval.plus <- as.data.frame(cbind(all_data_plus))
n.row.vec <- 1:nrow(hval.plus)

hval.plus.df <-  cbind(hval.plus, n.row.vec)
head(hval.plus.df)

quantile(hval.plus.df$all_data_plus, probs= seq(0, 1, 0.1), na.rm=FALSE)

a <- ggplot(hval.plus.df, aes(all_data_plus))
a + geom_histogram(binwidth = 0.01, col="white", fill="darkgreen") 

ggsave(file="h_val_dist_FIN.png")

