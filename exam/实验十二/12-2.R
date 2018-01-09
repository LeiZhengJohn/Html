dir="D:/RFile/实验十二"
setwd(dir)
file="e12-data-2-1-win.txt"
data<-read.table(file,head=T,sep="\t")
data

png("e12_data-2-1_boxplot.png")
boxplot(data)
dev.off()

shapiro.test(data[,1])
shapiro.test(data[,2])
shapiro.test(data[,3])

data2<-data.frame(X<-c(data[,1],data[,2],data[,3]),A<-factor(rep(1:3,c(24,24,24))))
bartlett.test(data)
library(car)
leveneTest(X~A,data=data2)
fligner.test(X~A,data=data2)

library( agricolae)
#H0:M1=M2=M3, H1:三者不等
kruskal.test(X~A,data=data2)

m<-aov(X~A,data=data2)
summary(m)

mm<-TukeyHSD(m)
mm
png("e12_data-2-1_TurkeyHSD_plot.png")
plot(mm)
dev.off()