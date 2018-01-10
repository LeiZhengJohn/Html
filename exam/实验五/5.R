#随机数生成
set.seed(1)
a<-seq(0,100,length.out=100)
set.seed(2)
b<-seq(0,100,length.out=50)
#t检验
t.test(a,b,var.equal=TRUE) #等方差t检验
t.test(a,b) #异方差t检验
#概率密度分布图
#a
png(file = "t_test_4.png")
curve(dnorm(x,mean(a,na.rm=TRUE),sd(a,na.rm=TRUE)),xlim=c(0,100),ylim=c(0,0.05),col="blue",lwd=3)
abline(v=mean(a,na.rm=TRUE),lty=3,lwd=3,col="blue") # 增加均值线
abline(v=mean(a,na.rm=TRUE)+sd(a,na.rm=TRUE),lty=3,lwd=3,col="blue") # 增加标准差线
abline(v=mean(a,na.rm=TRUE)-sd(a,na.rm=TRUE),lty=3,lwd=3,col="blue") # 增加标准差线
#b
curve(dnorm(x,mean(b,na.rm=TRUE),sd(b,na.rm=TRUE)),add=TRUE,xlim=c(0,100),ylim=c(0,0.05),col="red",lwd=3)
abline(v=mean(b,na.rm=TRUE),lty=3,lwd=3,col="red") # 增加均值线
abline(v=mean(b,na.rm=TRUE)+sd(b,na.rm=TRUE),lty=3,lwd=3,col="red") # 增加标准差线
abline(v=mean(b,na.rm=TRUE)-sd(b,na.rm=TRUE),lty=3,lwd=3,col="red") # 增加标准差线
dev.off()
