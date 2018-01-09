setwd("D:/RFile/实验十三")
data1 <- read.csv("1.csv",header = FALSE)
barplot(data[5:35,2],names.arg = data[5:35,1],cex.names = 0.6,main = "2013年中国各地医院数量统计图")

data2 <- read.csv("2.csv",header = TRUE)
plot(x=data2[,1],y=data2[,2],type = "o",col = "red",ylim=c(-10,40))
lines(x=data2[,1],y=data2[,3],type = "o", col = "blue")
lines(x=data2[,1],y=data2[,4],type = "o", col = "green")
legend("topright",legend=c("出生率","死亡率","自然增长率"),col=c("red","blue","green"),lwd=3,lty=c(1,1,1))

data3 <- read.csv("3.csv",header = FALSE)
barplot(data3[,2],names.arg = data3[,1],cex.names = 0.6,main = "2008年中国患病率统计图")

data4 <- read.csv("4.csv",header = TRUE)
plot(x=data4[,1],y=data4[,2],type = "o",col = "red",ylim=c(0,100),main="城市农村高血压患病情况")
lines(x=data4[,1],y=data4[,3],type = "o", col = "blue")
legend("topleft",legend=c("城市","农村"),col=c("red","blue"),lwd=3,lty=c(1,1))
