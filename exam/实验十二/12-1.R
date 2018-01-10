dir="D:/RFile/实验十二"
setwd(dir)
file="e12-data-1-1.txt"
data<-read.table(file,head=T,sep="\t")
data
x<-data[,2];y<-data[,3]

png("e12_data-1-1_boxplot.png")
boxplot(data[,2:3])
dev.off()

shapiro.test(x)
shapiro.test(y)

data2<-data.frame(X<-c(data[,2],data[,3]),A<-factor(rep(1:2,c(21,21))))
#Bartlett检验 - 如果我们的数据服从正态分布，那么这种方法将是最为适用的。对于正态分布的数据，这种检验极为灵敏；而当数据为非正态分布时，使用该方法则很容易导致假阳性误判。
bartlett.test(data[,2:3])
#或bartlett.test(X~A,data=data2)
#Levene检验 – 相较于Bartlett检验，这一方法更为稳健，这一方法被封装于car程序包中。
library(car)
leveneTest(X~A,data=data2)
#Fligner-Killeen检验 – 这是一个非参数的检验方法，完全不依赖于对分布的假设
fligner.test(X~A,data=data2)

#H0:Md=0，H1:Md≠0
wilcox.test(x, y, paired = TRUE, alternative = "two.sided")

#H0:μ1=μ2, H1: μ1≠μ2
t.test(x,y, paired = TRUE, var.equal=TRUE, alternative = "two.sided")

#H0:μ1=μ2, H1: μ1≠μ2
t.test(x,y, paired = TRUE, alternative = "two.sided")
