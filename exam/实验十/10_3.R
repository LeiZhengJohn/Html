dir="D:/RFile/实验十"
setwd(dir)
file="US_Temperatures_Data.txt"
data<-read.table(file,head=T,sep="\t")
colnames(data)
a<-max(data$JanTemp) - min(data$JanTemp) + 1 #设定颜色梯度区间
png(file = "plot_y_x_t_scatter.png")
cPal <- colorRampPalette(c('green','red'))
Cols <- cPal(a)[as.numeric(cut(data$JanTemp,breaks = a))]
plot(data$Long,data$Lat,pch = 20,col = Cols,cex=2)
dev.off()

model1=loess(JanTemp~Lat,data=data,span=0.4)
summary(model1)
png(file = "plot_T_Lat_loess.png")
plot(data$JanTemp~data$Lat,pch = 20,col = Cols,cex=2)
lines(data$Lat,model1$fit,col='red',lty=2,lwd=2)
dev.off()

#JanTemp~Long拟合
model2=loess(JanTemp~Long,data=data,span=0.8)
summary(model2)
png(file = "plot_T_Long_loess.png")
plot(data$JanTemp~data$Long,pch = 20,col = Cols,cex=2)
lines(data$Long,model2$fit,col='red',lty=2,lwd=2)
dev.off()

#二元线性回归的探索
lm.line<-lm(JanTemp~Lat+Long,data=data)
summary(lm.line)
png(file = "plot_y_x_t_lm.png")
par(mfrow=c(2,2))
plot(lm.line)
dev.off()

#Lat为线性，Long为三次项
model <- lm(JanTemp ~ Lat + poly(Long,3),data=data)
summary(model)
#模型参数的置信区间
confint(model, level=0.95)
#拟合VS残差图,如果这是一个拟合效果比较不错的模型，应该看不到任何一种模型的特征
png(file = "plot_T_Lat_Long_model_residuals.png")
#par(mfrow=c(2,2))
#plot(model)
plot(fitted(model),residuals(model))
dev.off()
