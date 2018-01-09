dir="D:/RFile/实验十"
setwd(dir)
library(ggplot2)
library(gridExtra) #针对ggplot2的多图排版
#几次项？=》更改这个参数即可
k=5
#一共生成7组数据，每组100个数值
group=7; n=100
#自变量最大区间
x_min=-3; x_max=3
#系数区间
b_min=-8; b_max=8
#则因变量理论区间
y_min=y_max=0
for(j in 0:k){y_min = y_min + b_min*(x_max^j); y_max = y_max + b_max*(x_max^j)}
#自变量波动区间
c_min=-1;c_max=1
#创建存储数据的data.frame，共3列，第一列group序号，第二列自变量x，第三列因变量y
data<-data.frame(matrix(NA,group*n,3))
colnames(data)<-c("group","x","y")
#formula<-data.frame(matrix(NA,group,1)) #存放方程式
#根据设定参数进行数据模拟
for(i in 1:group)
{
  set.seed(i+runif(1,0,100))
  x<-runif(n,min=x_min,max=x_max)
  b<-round(runif(k+1,min=b_min,max=b_max))
  c<-runif(n,min=c_min,max=c_max)
  x<-x+c
  y<-data.frame(matrix(0,n,1))
  for(m in 0:k){ y <- y + b[m+1] *(x^m) }
  from = (i-1)*n+1; to = n*i
  data[from:to,1]=rep(i,n)
  data[from:to,2]=x
  data[from:to,3]=y
}
#绘制一元多次项模拟散点图+拟合曲线
g1=ggplot(data, aes(x=x, y=y, colour=group)) + geom_point()#以颜色梯度区分
data$group <- as.factor(data$group) #group列定义为因子
g2=ggplot(data, aes(x=x, y=y, colour=group)) + geom_point() #以不同颜色区分
g3= ggplot(data, aes(x=x, y=y, colour=group)) + geom_point() + stat_smooth(method='lm', formula=y~poly(x,k)) #增加拟合曲线
g4= ggplot(data, aes(x=x, y=y, colour=group)) + geom_point() + stat_smooth(method='lm', formula=y~poly(x,k)) + theme(axis.title=element_text(face="bold",size=12), axis.text = element_text(face="bold",color="blue", size=10)) #增加图片修饰

#注意4张图的区别，输出到一张图片上
png(file = "plot_y_x-k_ggplot_5.png")
grid.arrange(g1, g2, g3, g4, ncol=2)
dev.off()