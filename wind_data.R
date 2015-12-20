wind_data<-function(path){
    ##读取数据，以UTF-8格式读取，不然会乱码
    res1 <- read.xlsx(path,sheetIndex = 1,encoding = "UTF-8")    
    ##res1 <- read.xlsx("2007-2014communication.xlsx",sheetIndex = 1,encoding = "UTF-8")
    
    ##预处理数据，删掉不用处理的行和列
    res1 <- res1[-nrow(res1),]
    res1 <- res1[-3:-5]
    res1 <- res1[-length(res1)]
    
    ##提取新的表格的表头 
    for(icol in 1:length(res1)){
        s[icol] <- unlist(strsplit(as.character(names(res1)[icol]),'\\.'))[1]
        
    }
    s <- s[!duplicated(s)]
    s <- c(s,"年份")
    
    ##创建一个新的表格
    res3 <- data.frame(s)
    names(res3) <- s
    res3 <- res3[-1,]
    
    ##处理数据
    for(year in 2007:2014){
        q <- grep(year,names(res1),value = TRUE)
        q1<-res1[c("证券代码","证券简称",q)]
        q1$年份 <- year
        names(q1) <- s
        res3 <- rbind(res3,q1)
        
    }
    ##按证券-时间排序
    res3 <- res3[order(res3[[1]],res3[[length(res3)]]),]
    
    return(res3)
    ##保存处理好的文件
    write.xlsx(res3,"res3.xlsx")

}