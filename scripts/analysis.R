rm(list = ls())
library(reshape2)
library(dplyr)
library(ggplot2)
library(knitr)
library(car)
library(zoib)

set.seed(42)
data <- read.csv("../results/TSS_500_h_value_tables/all_h_CLARK_sequences.csv" , header = FALSE)
siData <- read.table("../data/Dm_promoter/hoskins_tsr_table_SI.txt" , header = TRUE , sep = '\t')
names(data)[5:ncol(data)] <- as.character(-250:250)
names(data)[1:4] <- c("chrom" , "tsrBeg" , "tsrEnd" , "strand")

dataMelted <- melt(data , measure.vars = as.character(-250:250) , variable.name = "dist" , value.name = "het")
dataMelted$dist <- as.numeric(as.character(dataMelted$dist))
siData <- siData[siData$chr %in% dataMelted$chrom, ]
siData$chr <- droplevels(siData$chr)
dataMelted$cluster <- 0
dataMelted$hetNonZero <- dataMelted$het != 0
dataMelted$absDist <- abs(dataMelted$dist)
testRows <- sample(1:nrow(dataMelted) , 10000)
dataAll <- dataMelted
dataMelted <- dataAll[testRows, ]

for (chrom in levels(dataMelted$chrom)) {
    dataWorking <- filter(dataMelted , chrom == chrom)
    siDataWorking <- filter(siData , chr == chrom)
    for (i in 1:nrow(siDataWorking)) {
        center <- siDataWorking$dominant_ctss[i]
        if(nrow(dataMelted[dataMelted$tsrBeg == center | dataMelted$tsrEnd == center, ]) > 0) {
            dataMelted[dataMelted$tsrBeg == center | dataMelted$tsrEnd == center, ]$cluster <- siDataWorking$cluster[i]
        }
    }
}
dataMelted$shape.index <- 0
for (cluster in unique(siData$cluster)) {
    dataMelted$shape.index[dataMelted$cluster == cluster] <- siData$shape.index[siData$cluster == cluster]
}
dataMelted$hetLogit <- with(dataMelted , log(het / (1 - het)))

m0 <- glm(hetNonZero ~ shape.index + absDist , dataMelted , family = binomial(link = "logit"))
m0.1 <- glm(het ~ 1 , dataMelted[dataMelted$hetNonZero == 1, ] , family = gaussian)
dataNew <- data.frame(shape.index = seq(-3 , 2 , by = 0.1) , absDist = 0)
muHat <- predict(m0.1 , dataNew , type = "response")
denom <- 1 + exp(m0$coeff[1] + m0.1$coeff[1] + dataNew$shape.index * -m0$coeff[2])
m1 <- glm(I(het + 1) ~ exp(shape.index) + absDist + chrom , dataMelted[dataMelted$hetNonZero == 1, ] , family = gaussian)
m2 <- update(m1 , . ~ . - absDist)
m3 <- update(m2 , data = dataMelted)
m4 <- update(m3 , I(m0$fitted * (het + 1)) ~ .)
m5 <- update(m3 , . ~ . + m0$fitted)
m6 <- lm(hetLogit ~ exp(shape.index) + absDist + chrom , dataMelted)

testRows2 <- sample(1:nrow(dataAll[-testRows, ]) , 10000)
data2 <- dataAll[testRows2, ]
for (chrom in levels(data2$chrom)) {
    dataWorking <- filter(data2 , chrom == chrom)
    siDataWorking <- filter(siData , chr == chrom)
    for (i in 1:nrow(siDataWorking)) {
        center <- siDataWorking$dominant_ctss[i]
        if(nrow(data2[data2$tsrBeg == center | data2$tsrEnd == center, ]) > 0) {
            data2[data2$tsrBeg == center | data2$tsrEnd == center, ]$cluster <- siDataWorking$cluster[i]
        }
    }
}
data2$shape.index <- 0
for (cluster in unique(siData$cluster)) {
    data2$shape.index[data2$cluster == cluster] <- siData$shape.index[siData$cluster == cluster]
}

euid <- 1:nrow(dataMelted)
mZoib <- zoib(
    het ~ shape.index + absDist | 1 | shape.index + absDist , 
    data = dataMelted , zero.inflation = TRUE , one.inflation = FALSE , 
     EUID = euid , n.iter = 1000 , n.burn = 50
    )
mZoibRandom <- zoib(
    het ~ shape.index + absDist | 1 | shape.index + absDist | 1 , joint = FALSE , 
    data = dataMelted , zero.inflation = TRUE , one.inflation = FALSE ,
    EUID = dataMelted$chrom , random = 13 , n.iter = 1000 , n.burn = 50
    )

resids <- data.frame(resids = as.numeric(mZoib$resid[[1]]) , pred = as.numeric(mZoib$ypred[[1]]))
summ <- summary(mZoib$coeff)
summRandom <- summary(mZoibRandom$coeff)
stats <- as.data.frame(cbind(summ$statistics[ ,1] , summ$quantiles[ ,c(1 , 5)]))
stats$model <- as.factor("zoib")
statsRandom <- as.data.frame(cbind(summRandom$statistics[ ,1] , summRandom$quantiles[ ,c(1 , 5)]))
statsRandom$model <- as.factor("zoib-random")
rownames(stats) <- c("intercept" , "SI" , "absDist" , "intercept Z" , "SI Z" , "absDist Z" , "a1 + a2")
stats$param <- rownames(stats)
rownames(statsRandom)[1:7] <- rownames(stats)
statsRandom$param <- rownames(statsRandom)
allStats <- rbind(stats , statsRandom)

ggplot(allStats , aes(y = V1 , col = model)) + 
    geom_pointrange(aes(x = param , ymin = `2.5%` , ymax = `97.5%`) , position = position_dodge(width = 0.5)) +
    geom_hline(yintercept = 0 , lty = 2) +
    ylab("coefficient estimate")

plot(as.numeric(mZoib$ypred[[1]]) ~ rep(dataMelted$shape.index , nrow(mZoib$ypred[[1]])) , col = rgb(0 , 0 , 0 , 0.1))
