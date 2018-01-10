dir="D:/RFile/实验九"
setwd(dir) # 设定工作目录
file="Data_Healthy_Breakfast.txt"
data<-read.table(file,head=TRUE,sep="\t")
#查看数据信息
head(data)
ncol(data)
nrow(data)

png("lec10_Healthy_Breakfast_pairs.png")
pairs(data[,4:16],panel=panel.smooth)
dev.off()

lm0<-lm(rating~.,data=data[,4:16])
summary(lm0)

lm.step<-step(lm0,direction="backward")
summary(lm.step)

png(file = "lec10_Healthy_Breakfast_lm_data.png")
par(mfrow=c(2,2)) #同一个图形文件中绘制2*2=4个图像
plot(lm.step)
dev.off()

library(car)
vif(lm.step)

#car包里influencePlot()函数能一次性同时检查离群点、高杠杆点、强影响点
png("lec10_Healthy_Breakfast_influencePlot.png")
influencePlot(lm.step,id.method = "identity", main="Influence Plot",sub="Circle size is proportional to Cook's distance")
dev.off()



table(data[,2]) #查看第2列数据种类
table(data[,3]) #查看第3列数据种类
data2<-data.frame(matrix(NA,77,20))
for(i in 1:nrow(data))
{
  #第二列mfr分类
  if(data[i,2]=="A"){data2[i,1:6]<-c(0,0,0,0,0,0)}
  if(data[i,2]=="G"){data2[i,1:6]<-c(1,0,0,0,0,0)}
  if(data[i,2]=="K"){data2[i,1:6]<-c(0,1,0,0,0,0)}
  if(data[i,2]=="N"){data2[i,1:6]<-c(0,0,1,0,0,0)}
  if(data[i,2]=="P"){data2[i,1:6]<-c(0,0,0,1,0,0)}
  if(data[i,2]=="Q"){data2[i,1:6]<-c(0,0,0,0,1,0)}
  if(data[i,2]=="R"){data2[i,1:6]<-c(0,0,0,0,0,1)}
  #第三列type分类
  if(data[i,3]=="C"){data2[i,7]<-0}
  if(data[i,3]=="H"){data2[i,7]<-1}
}
data2[,8:20]<-data[,4:16]

rownames(data2)<- data[,1]
colnames(data2)<- c(paste("mfr_",c("G","K","N","P","Q","R"),sep=""),"type_CH",colnames(data)[4:16])
head(data2)

png("lec10_Healthy_Breakfast_pairs2.png")
pairs(data2,panel=panel.smooth)
dev.off()

lm0<-lm(rating~.,data=data2)
summary(lm0)

lm.step<-step(lm0,direction="backward")
summary(lm.step)

png(file = "lec10_Healthy_Breakfast_lm_data2.png")
par(mfrow=c(2,2)) #同一个图形文件中绘制2*2=4个图像
plot(lm.step)
dev.off()

vif(lm.step)

png("lec10_Healthy_Breakfast_influencePlot2.png")
influencePlot(lm.step,id.method = "identity", main="Influence Plot",sub="Circle size is proportional to Cook's distance")
dev.off()