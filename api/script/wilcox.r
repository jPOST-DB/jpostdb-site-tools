library(curl)
library(jsonlite)
library(exactRankTests)

argv <- commandArgs(trailingOnly=TRUE)
d <- fromJSON(argv[1])  # e.g.) "http://db-dev.jpostdb.org/rest/api/spectral_counting?dataset1=DS81_1%20DS82_1%20DS83_1%20DS85_1%20DS86_1&dataset2=DS87_1%20DS88_1%20DS89_1"
a <- table(d[1,])
n1 <- as.numeric(a["0"]) + 1
n2 <- n1 + 1
n3 <- as.numeric(a["1"]) + n1
p <- 1:nrow(d)
f <- p
p[1] <- "p-value"
f[1] <- "logFC"

for (i in 2:nrow(d)){
  p[i] <- wilcox.exact(as.numeric(d[i,2:n1]),as.numeric(d[i,n2:n3]),paired=F)$p.value
  fc <- 0
  c <- 0
  for(j in 2:n1){
     if(d[i, j] == "0") next
     for(k in n2:n3){
       if(d[i, k] == "0") next
       fc <- fc + log2(as.numeric(d[i,k])/as.numeric(d[i,j]))
       c <- c + 1
     }
   }
   f[i] <- fc / c
}

r <- cbind(d[,1],p,f)
write.table(r,file="",sep="\t",quote=F,row.names=F,col.names=F)
