dir="D:/RFile/实验十一"
setwd(dir)
file="15生信成绩.txt"
scores<-read.table(file,head=T,sep="\t")
colnames(scores)
ncol(scores)
#[1] 25 =》24门课程
nrow(scores)
#[1] 30
#创建数据框
data<-data.frame(scores[,2:25])
colnames(data)<-paste("x",1:24, sep="")
rownames(data)<-scores[,1]
data #查看数据

library(psych)
corr.test(data)

#原数据：
png("boxplot1.png")
boxplot(data,las=2)
dev.off()
#数据中心化，使其均值变为零【原点】
data2<-scale(data, center=T,scale=F)
data2
png("boxplot2.png")
boxplot(data2,las=2)
dev.off()
#数据围绕0附近波动，但是方差变异很大
#数据标准化，除以方差
data3<-scale(data, center=T, scale=T)
data3
png("boxplot3.png")
boxplot(data3,las=2)
dev.off()

mc<-cov(data3)
mc

#cor：逻辑变量，若为cor=T表示用样本的相关矩阵R作主成分分析，cor=F, 表示用样本的协方差矩阵s作为主成分分析
pca<-princomp(data,cor=T)
pca2<-princomp(data2,cor=T)
pca3<-princomp(data3,cor=T)
#以上几个结果相同，princomp自动进行上述中心化和标准化处理
pca

summary(pca)
pca[]#查看详细信息
pca$sdev #Standard deviation
pca$loadings #loading系数矩阵
pca$center #每一门课程均值=》数据中心化
pca$scale #每一门课程方差=》数据标准化
pca$scores #每个样本每个组分的得分
pca$loadings #查看loadins信息
pca$loadings[] #查看loadings全部数值
#计算得到各个样本主成分的数据=》等价于pca$scores
pca_data <- predict(pca)

#针对princomp()对象的plot方法#
#该方法可以绘制展示每个主成分与其自身方差贡献度相关性的悬崖碎石图。
png("lec12_bar-stone_plot1.png",width=600*3,height=3*300,res=72*3)
par(mfrow=c(1,2),las=2)
#条形图
plot(pca)
abline(h=1,type="2",col="red")
#主成分的碎石图
screeplot(pca, type="lines")
abline(h=1,type="2",col="red")
dev.off()

#=》主成分分布更为离散=》把30个样本区分的更好
#得分图（Score plot）
png("lec12_15scores_scores_plot6.png",width=600*3,height=3*400,res=72*3)
par(mfrow=c(2,3))
#主成分分析之后的前两个主成分得分绘图
plot(pca$scores[,1], pca$scores[,2],type="n")
text(pca$scores[,1],pca$scores[,2],labels=rownames(pca$scores),cex=0.8)
plot(pca$scores[,1], pca$scores[,3],type="n")
text(pca$scores[,1],pca$scores[,3],labels=rownames(pca$scores),cex=0.8)
plot(pca$scores[,1], pca$scores[,4],type="n")
text(pca$scores[,1],pca$scores[,4],labels=rownames(pca$scores),cex=0.8)
plot(pca$scores[,2], pca$scores[,3],type="n")
text(pca$scores[,2],pca$scores[,3],labels=rownames(pca$scores),cex=0.8)
plot(pca$scores[,2], pca$scores[,4],type="n")
text(pca$scores[,2],pca$scores[,4],labels=rownames(pca$scores),cex=0.8)
plot(pca$scores[,3], pca$scores[,4],type="n")
text(pca$scores[,3],pca$scores[,4],labels=rownames(pca$scores),cex=0.8)
dev.off()

png("lec12_15scores_loadings_plot6.png",width=600*3,height=3*400,res=72*3)
par(mfrow=c(2,3))
#主成分分析之后的前两个主成分得分绘图
plot(pca$loadings[,1], pca$loadings[,2],type="n")
text(pca$loadings[,1],pca$loadings[,2],labels=rownames(pca$loadings),cex=0.8)
plot(pca$loadings[,1], pca$loadings[,3],type="n")
text(pca$loadings[,1],pca$loadings[,3],labels=rownames(pca$loadings),cex=0.8)
plot(pca$loadings[,1], pca$loadings[,4],type="n")
text(pca$loadings[,1],pca$loadings[,4],labels=rownames(pca$loadings),cex=0.8)
plot(pca$loadings[,2], pca$loadings[,3],type="n")
text(pca$loadings[,2],pca$loadings[,3],labels=rownames(pca$loadings),cex=0.8)
plot(pca$loadings[,2], pca$loadings[,4],type="n")
text(pca$loadings[,2],pca$loadings[,4],labels=rownames(pca$loadings),cex=0.8)
plot(pca$loadings[,3], pca$loadings[,4],type="n")
text(pca$loadings[,3],pca$loadings[,4],labels=rownames(pca$loadings),cex=0.8)
dev.off()

