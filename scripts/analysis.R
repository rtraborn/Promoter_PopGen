rm(list = ls())
library(reshape2)
library(dplyr)
library(ggplot2)
data <- read.csv("../results/TSS_500_h_value_tables/all_h_CLARK_sequences.csv" , header = FALSE)
names(data)[5:ncol(data)] <- as.character(-250:250)
names(data)[1:4] <- c("chrom" , "tssStart" , "tssEnd" , "dir")

dataMelted <- melt(data , measure.vars = as.character(-250:250) , variable.name = "dist" , value.name = "het")
dataMelted$dist <- as.numeric(as.character(dataMelted$dist))

# rough plot of nucleotide diversity by distance from TSS
pdf("../Plots/hetByDistance.pdf")
group_by(dataMelted , dist , chrom) %>%
    summarize(mean(het)) %>%
    ggplot(aes(x = abs(dist) , y = `mean(het)`)) + 
    geom_point(aes(color = chrom))
dev.off()

m0 <- lm(het ~ . , dataMelted)
m1 <- update(m0 , . ~ . - dist + abs(dist))
