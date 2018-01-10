setwd("D:/RFile/สตั้ม๙")
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

p = NULL
r = NULL
for(i in 1:nrow(data)){
  b <- unlist(data[i,3:67])
  x <- cor.test(a,b, method="pearson")
  p <- c(p,x$p.value)
  r <- c(r,x$estimate)
}
names(p)<-data[,2]
names(r)<-data[,2]

p_value = 0.01
r_cutoff = 0.6
p2 <- p[p<p_value]
r2 <- r[r>r_cutoff]
length(p2)
length(r2)

genes <- intersect(names(p2),names(r2))
genes[-match("ARHGAP26",genes)]
length(genes)
tail(genes)
genes2 <-c(gene_name_a,genes[1:645])
out = "pearson-related-genes.txt"
write.table(genes2,out)

