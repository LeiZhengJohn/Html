for(i in 1:48107){
  ge<-data.frame(x<-t(data[i,3:14]), A<-factor(substring(Columns(gds6100)$protocol,1,9)), B<-factor(substring(Columns(gds6100)$time,6)))
  #不考虑交互作用
  ge.aov<-aov(x~A+B,data=ge)
  ge.aov2<-aov(x~A*B,data=ge)
  if(summary(ge.aov)[[1]]["Pr(>F)"][[1]][1]<0.1 && summary(ge.aov)[[1]]["Pr(>F)"][[1]][2]<0.1 && summary(ge.aov2)[[1]]["Pr(>F)"][[1]][1]>0.1 && summary(ge.aov2)[[1]]["Pr(>F)"][[1]][2]>0.1 && summary(ge.aov2)[[1]]["Pr(>F)"][[1]][3]>0.1){
    break
  }
}

n=1
row.names<-rownames(data)
sam.row.name <- sample(row.names,n,replace=F)
sam.row.name
ge<-data.frame(x<-t(data[sam.row.name,3:14]), A<-factor(substring(Columns(gds6100)$protocol,1,9)), B<-factor(substring(Columns(gds6100)$time,6)))
#考虑交互作用
ge.aov2<-aov(x~A*B,data=ge)
summary(ge.aov2)