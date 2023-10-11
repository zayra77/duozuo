library(lattice) #调入函数包  
library(MASS)  
library(nnet)
library(mice) # 载入mice包
setwd("C:/文件路径")
getwd()
rm(list = ls()) # 清空

aa<- read.csv('文件名.csv',header = T)
#View(aa)

imp<- mice(aa,m=5,seed = 随机种子,nnet.MaxNWts = 10000) # 创建包含默认5个插补数据集的列表
fit=with(imp,glm(class~指标1+指标2+指标3,data=aa,family = binomial(link = 函数类型)))#选择插补模型 
fit
fit1<-pool(fit)
summary(fit1)

complete(imp, action = m) # 括号内的#指的是m个完整数据集中哪一个
datasetN <- complete(imp, action = m)
write.csv(datasetN,"输出文件名.csv", row.names=F)
