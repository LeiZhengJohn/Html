#设定工作目录
dir="D:/RFile/实验十一"
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
p_value = 0.05
up = 40 #lung cancer 上调40倍
down = 1/40 #lung cancer 下调1/40倍
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
subdata<-log(data[probes,3:67]) #从原始基因表达谱数据表中提取筛选出来的基因数据
rownames(subdata)<-probes #设定探针IDs为行标题
nrow(subdata)

#数据标准化，除以方差
subdata2<-scale(t(subdata), center=T, scale=T)
rownames(subdata2)<-rep(1:65) #使用数据编号代替样本名称
#subdata2
png("lec12_gds4794_clustering_boxplot1.png",width=600*3,height=300*3,res=72*3)
par(mfrow=c(1,2),las=2)
boxplot(t(subdata))
boxplot(subdata2)
dev.off()

d<-dist(subdata2, method = "euclidean")
#r语言中使用hclust(d, method = "complete", members=NULL) 来进行层次聚类。
hc<-hclust(d,"single")
png("lec12_gds4794_clustering_tree_plot.png",width=600,height=300)
plot(hc)
dev.off()

#使用rect.hclust(tree, k = NULL, which = NULL, x = NULL, h = NULL,border =2, cluster = NULL)来确定类的个数。 tree就是求出来的对象。k为分类的个数，h为类间距离的阈值。border是画出来的颜色，用来分类的
png("lec12_gds4794_clustering_tree_plot2.png", width=600,height=300)
plot(hc)
rect.hclust(hc,k=4)
dev.off()
result=cutree(hc,k=4) #该函数可以用来提取每个样本的所属类别
result