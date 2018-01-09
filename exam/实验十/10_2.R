dir="D:/RFile/实验十"
setwd(dir)
#加载GEOquery
library(GEOquery)
#加载本地的数据
gds4794 <- getGEO(filename='GDS4794.soft.gz')
#查看数据类型
mode(gds4794)
#查看注释信息
Meta(gds4794)
#查看列注释信息=》用来确定哪些列是肿瘤，哪些列是正常对照
Columns(gds4794)
#1：23是肺癌，24：65是正常组织
data<-Table(gds4794)
#查看数据表的列名
colnames(data)
#查看数据表行列数
ncol(data)
#[1] 67
nrow(data)
#[1] 54675
#前面两列是标题列，分别为探针id和基因名称
#3：25列是 lung cancer，26：67列是 normal
#第一列探针IDs定义为data的行标题
rownames(data)<-data[,1]

#随机抽取至少10行数据
n=10
#使用以下代码进行循环测试：齐方差、F检验，p>0.1；齐方差、F检验，双因素p<0.1，无交互作用；齐方差、F检验，双因素p无要求，p<0.1
#按行随机抽样【实验结果中需要记录】
row.names<-rownames(data)
sam.row.name <- sample(row.names,n,replace=F)
sam.row.name #查看抽中的数据行探针id
subdata<-data[sam.row.name,3:67] #提取抽样数据
#加上样本病理类型数据共n+1列
#初始化数据表
data2<-data.frame(matrix(NA,65, n+1))
#增加样本病理类型分类数据，肺癌=1，其他正常=0
data2[,1]<-c(rep(1,23),rep(0,42))
data2[,2:(n+1)]<-t(log(subdata)) #后面n列存放筛选出来的基因数据，注意矩阵行列转换
colnames(data2)<-c("y",paste("x",1:n,sep="")) #设定列标题y,x1,x2,...,x10
#以样本类型为因变量y，其他所有基因表达式水平为自变量x1,x2,...x10，进行总体回归分析
glm0<-glm(y~.,family=binomial(link='logit'),data=data2)
summary(glm0)
#向后逐步回归法
glm.step<-step(glm0,direction="backward")
summary(glm.step)
#绘制回归评估的4张图
png(file = "glm4.png")
par(mfrow=c(2,2))
plot(glm.step)
dev.off()
#car包里的influencePlot()函数能一次性同时检查离群点、高杠杆点、强影响点
library(car)
png("influencePlot.png")
influencePlot(glm.step,id.method = "identity", main="Influence Plot",sub="Circle size is proportional to Cook's distance")
dev.off()
#绘制subdata的热图
colnames(subdata)<-Columns(gds4794)$disease.state
png(file = "heatmap1.png")
heatmap(as.matrix(log(subdata)), Rowv = NA, Colv = NA)
dev.off()

#变量初始化，用来存放计算结果中的p.value和fold change值
p=NULL
fold.change=NULL
#R用Sys.time()可以查看当前系统时间
#程序开始时记录：
timestart<-Sys.time()
#基因表达谱遍历
for(i in 1:nrow(data))
{
  a <- unlist(data[i,3:25])
  b <- unlist(data[i,26:67])
  fold.change<-c(fold.change,mean(a,na.rm=TRUE)/mean(b,na.rm=TRUE))
  x<-t.test(a,b)
  p<-c(p,x$p.value)
}
#程序临结束时记录：
timeend<-Sys.time()
#程序运行时间：
timeend-timestart
#Time difference of 51.29762 secs
#data第一列探针名IDs作为p和fold.change的名称
names(p)<-data[,1]
names(fold.change)<-data[,1]
#设定阈值进行筛选
p_value = 0.01
up = 50 #lung cancer 上调2倍
down = 0.02 #lung cancer 下调2倍
#筛选
p2 <- p[p<p_value] #p值筛选
fc.up <- fold.change[fold.change>up] #上调基因
fc.down <- fold.change[fold.change<down] #下调基因
length(p2); length(fc.up); length(fc.down) #查看筛选结果
#交集计算
probes.up<-intersect(names(p2),names(fc.up)) #符合统计学显著性的上调基因
length(probes.up)
probes.down<-intersect(names(p2),names(fc.down)) #符合统计学显著性的下调基因
length(probes.down)

probes<-union(probes.up,probes.down) #合并合统计学显著性的上调和下调基因
#上述过程合并进行
#probes <- intersect(names(p2),union(names(fc.up),names(fc.down)))
length(probes)
subdata2<-data[probes,3:67] #从原始基因表达谱数据表中提取筛选出来的基因数据
rownames(subdata2)<-probes #设定探针IDs为行标题
nrow(subdata2)
#如果筛选的基因数量过多，接下来则无法进行下去
#加上样本病理类型数据共17列
data3<-data.frame(matrix(NA,65, 17)) #初始化数据表
data3[,1]<-c(rep(1,23),rep(0,42)) #增加样本病理类型分类数据，肺癌=1，其他正常=0
data3[,2:17]<-t(log(subdata2)) #后面16列存放筛选出来的基因数据，注意矩阵行列转换
colnames(data3)<-c("y",paste("x",1:16,sep="")) #设定列标题
#以样本类型为因变量y，其他所有基因表达式水平为自变量x1,x2,...，进行总体回归分析
glm0<-glm(y~.,family=binomial(link='logit'),data=data3)
summary(glm0)
glm.step<-step(glm0,direction="backward")
summary(glm.step)
png(file = "lec11_ICU_glm.png")
par(mfrow=c(2,2))
plot(glm.step)
dev.off()
#car包里的influencePlot()函数能一次性同时检查离群点、高杠杆点、强影响点。
library(car)
png("influencePlot.png")
influencePlot(glm.step,id.method = "identity", main="Influence Plot",sub="Circle size is proportional to Cook's distance")
dev.off()
#绘制subdata2的热图
colnames(subdata2)<-Columns(gds4794)$disease.state
png(file = "heatmap.png")
heatmap(as.matrix(log(subdata2)), Rowv = NA, Colv = NA)
dev.off()