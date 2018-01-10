dir="D:/RFile/实验八"
setwd(dir)
library(GEOquery)
gds6100 <- getGEO("GDS6100",destdir=dir)
#查看数据类型
mode(gds6100)
#查看注释信息
Meta(gds6100)
#查看列注释信息=》用来确定哪些列是肿瘤，哪些列是正常对照
Columns(gds6100)
#提取数据
data<-Table(gds6100)
#查看数据表的列名
colnames(data)
#查看数据表行列数
ncol(data)
nrow(data)
#前面两列是标题列，分别为探针id和基因名称
#3：8列是 miRNA135b transfected，9：14列是 scambled transfected
rownames(data)<-data[,1]
#随机抽取至少1列数据
n=1
#按行随机抽样
row.names<-rownames(data)
sam.row.name <- sample(row.names,n,replace=F)
sam.row.name

ge<-data.frame(x<-t(data[sam.row.name,3:14]), A<-factor(substring(Columns(gds6100)$protocol,1,9)), B<-factor(substring(Columns(gds6100)$time,6)))
ge

#正态性检验
shapiro.test(x)

#方差齐性检验
bartlett.test(x~A,data=ge)
bartlett.test(x~B,data=ge)

#绘图查看数据分布规律
par(mfrow=c(2,2),las=2, cex.axis=1.2, cex.lab=1.2)
plot(x~A+B,data=ge)
interaction.plot(A,B,x,legend=F)
interaction.plot(B,A,x,legend=F)

#不考虑交互作用
ge.aov<-aov(x~A+B,data=ge)
summary(ge.aov)

#考虑交互作用
ge.aov2<-aov(x~A*B,data=ge)
summary(ge.aov2)

