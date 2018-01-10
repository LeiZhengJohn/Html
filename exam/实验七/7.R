setwd("D:/RFile/สตั้ฦ฿")
library(GEOquery)
gds4794 <- getGEO(filename='GDS4794.soft.gz')

data<-Table(gds4794)
rownames(data)<-data[,1]
row.name = rownames(data)

n = 1
set.seed(1)
sam.row.name = sample(row.name,n,replace=F)
sam.row.name
a <- unlist(data[sam.row.name,3:67])
gene_name_a <- as.character(data[sam.row.name,2])
gene_name_a

xb = NULL
xk = NULL
xr = NULL
xp = NULL
for(i in 1:nrow(data)){
  if(data[i,1] != sam.row.name){
    b <- unlist(data[i,3:67])
    lm.sol <- lm(b~1+a)
    suma <- summary(lm.sol)
    xb <- c(xb,lm.sol$coefficients[1])
    xk <- c(xk,lm.sol$coefficients[2])
    xr <- c(xr,suma$r.squared)
    pv <- 1-pf(suma$fstatistic[1],suma$fstatistic[2],suma$fstatistic[3])
    xp <- c(xp,pv)
  }
}
names(xb)<-data[-which(data$ID_REF==sam.row.name),1]
names(xk)<-data[-which(data$ID_REF==sam.row.name),1]
names(xr)<-data[-which(data$ID_REF==sam.row.name),1]
names(xp)<-data[-which(data$ID_REF==sam.row.name),1]

p_value = 0.01
r_cutoff = 0.65
xp2 <- xp[xp<p_value]
xr2 <- xr[xr>r_cutoff]
genes <- intersect(names(xp2),names(xr2))
length(genes)

maxgene = unlist(data[which(data$ID_REF=="1556761_at"),3:67])
re_lm.sol = lm(maxgene~1+a)
summary(re_lm.sol)

png(file = "plot.png")
par(mfrow=c(2,2))
plot(re_lm.sol)
dev.off()

png(file = "plot2.png")
plot(a,maxgene,lwd=2,main="plot2")
y_mean=mean(maxgene)
abline(h=y_mean,col="blue")
x_mean=mean(a)
abline(v=x_mean,col="purple")
abline(re_lm.sol,col="red")
dev.off()

aov(a~maxgene)
summary(aov(a~maxgene))
