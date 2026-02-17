argv <- commandArgs(trailingOnly=TRUE)
d <- read.table(argv[1])
w <- as.numeric(argv[2])
p <- 1:nrow(d)
for(i in 1:nrow(d)){
  p[i] <- fisher.test(matrix(as.numeric(d[i,2:5]), nrow=2))$p.value
  if(p[i] > 1){ p[i] <- floor(p[i]) }
}
library(qvalue);
q <- qvalue(p)$qvalues
r <- cbind(formatC(d[,1],width=w,flag="0"),p,q)
write.table(r,file="",sep="\t",quote=F,row.names=F,col.names=F)
