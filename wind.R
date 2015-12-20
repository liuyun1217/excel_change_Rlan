res1 <- read.xlsx("2007-2014communication.csv",sheetIndex = 1,encoding = "UTF-8")
res2 <- gather(res1,年份,数据,-证券代码,-证券简称)
res2 <- res2[order(res2[[1]],res2[[3]]),]
grep(pattern = "营业收入",res2$年份,value = TRUE)

len2007 <- length(data2007)
data2007 <- grep("2007",scw1$年份,value = TRUE)
newdata <- data.frame(scw1,stringsAsFactors = FALSE)
s <- list(newdata)
for(icol in 1:length(data2007)){
    newdata[icol,] <- scw1[scw1$年份 == grep("2007",scw1$年份,value = TRUE)[icol],]
    s[icol] <- unlist(strsplit(as.character(newdata$年份[icol]),'\\.'))[1]
    
}
newdata <- newdata[1:len2007,]
s <- s[1:len2007]

newdata$年份 <- s
newdata$year <- "2007"

b <- list(c(names(res1)[1],names(res1)[2],s))
a <- data.frame(c(b),stringsAsFactors = FALSE)

a[1,] <- c(as.character(newdata$证券代码[1]),as.character(newdata$证券简称[1]),newdata$数据)


for(icol in 1:length(res1)){
    s[icol] <- unlist(strsplit(as.character(names(res1)[icol]),'\\.'))[1]
    
    
}
s <- s[!duplicated(s)]
s <- c(s,"年份")
res3 <- data.frame(s)
names(res3) <- s
res3 <- res3[-1,]


for(year in 2007:2014){
    q <- grep(year,names(res1),value = TRUE)
    q1<-res1[c("证券代码","证券简称",q)]
    q1$年份 <- year
    names(q1) <- s
    res3 <- rbind(res3,q1)
    
}


q <- grep("2007",names(res1),value = TRUE)
q1<-res1[c("证券代码","证券简称",q)]
q1$nianfen <- "2007"
names(q1) <- s

w <- grep("2008",names(res1),value = TRUE)
w1<-res1[c("证券代码","证券简称",w)]
w1$nianfen <- "2008"
names(w1) <- s

