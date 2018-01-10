dir="D:/RFile/实验十二"
setwd(dir)
file="e12-data-3-1-win.txt"
data<-read.table(file,head=T,sep="\t")
data

png("e12_data-3-1_boxplot.png")
boxplot(data[,2:5])
dev.off()

apply(data[,2:5],2,shapiro.test)

data2<-data.frame(X<-c(data[,2],data[,3],data[,4],data[,5]), A<-factor(rep(1:4,rep(9,4))))
bartlett.test(data[,2:5])
library(car)
leveneTest(X~A,data=data2)
fligner.test(X~A,data=data2)

dm<-as.matrix(data[,2:5])
dimnames(dm) <- list(1:9, c("A", "B", "C", "D"))
friedman.test(dm)

m<-aov(X~A,data=data2)
summary(m)

mm<-TukeyHSD(m)
mm
png("e12_data-3-1_TurkeyHSD_plot.png")
plot(mm)
dev.off()
