setwd('D:/RFile/实验五')
data <- read.table('15生信成绩.txt',sep = '\t',header = T)
en2 <- data[,5]
en4 <- data[,4]
en2_avg = mean(en2)
en4_avg = mean(en4)
dnorm_png<-png("en2VSen4.png") #定义图片文档
hist(en2, freq = F, breaks = 10,xlim = c(40,100)) #绘制频率分布直方图
curve(dnorm(x,mean(en2,na.rm=TRUE), sd(en2,na.rm=TRUE)),col="blue", lwd=3, add=TRUE) #绘制概率分布曲线
abline(v=en2_avg,lty=3,lwd=3,col="orange") #增加均值线
hist(en4, freq = F, breaks = 10,col = 'green',xlim=c(40,100),add=T)
curve(dnorm(x,mean(en4,na.rm=TRUE), sd(en4,na.rm=TRUE)),col="red", lwd=3, add=TRUE)
abline(v=en4_avg,lty=3,lwd=3,col="orange")
dev.off() #保存图片文档