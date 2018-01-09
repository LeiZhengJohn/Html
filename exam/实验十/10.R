dir="D:/RFile/สตั้สฎ"
setwd(dir)
file="US_Temperatures_Data.txt"
data<-read.table(file,head=T,sep="\t")
colnames(data)

a<-max(data$JanTemp) - min(data$JanTemp) + 1
png(file = "plot_y_x_t_scatter.png")
cPal <- colorRampPalette(c('green','red'))
Cols <- cPal(a)[as.numeric(cut(data$JanTemp,breaks = a))]
plot(data$Long,data$Lat,pch = 20,col = Cols,cex=2)
dev.off()

model <- lm(JanTemp~Lat + Long + I(Long^2) + I(Long^3),data=data)
summary(model)

par(mfrow=c(2,2))
plot(model)