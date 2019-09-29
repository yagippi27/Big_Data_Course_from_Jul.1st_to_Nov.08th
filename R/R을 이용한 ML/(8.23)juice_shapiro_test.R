install.packages("dplyr")
library(dplyr)

setwd("D:/workspace/PROJECT/R_project/")

sales= read.csv("sales.csv", header = TRUE)
sales

juice = sales %>%
  select(1:9) %>%
  filter(CATEGORY =='과즙음료')

juice

write.csv(juice, file = "part1.csv", row.names = TRUE)

shapiro.test(juice$QTY)

# 결과값
# Shapiro-Wilk normality test \n data:juice$QTY \n W = 0.97503, p-value = 0.255
# juice$QTY는 정규분포를 따른다.

# -> 그렇지만 더 진행하여 car와 nortest 라이브러리를 실행해 본다.

juice2 = juice[sample(nrow(juice), 300, replace=T), ]
juice2

# juice의 60개 항목을 무작위 추출하여 300개를 만듬

install.packages("car")
library(car)
powerTransform(juice2$QTY)


# 결과값 
# Estimated transformation parameter \n juice$QTY \n 0.4671245 
# juice$QTY값을 0.4671245승 하면 정규성 가정을 만족할 수 있다고 추정해 줌

juice3 = juice2$QTY^0.4671245

install.packages("nortest")
library(nortest)
ad.test(juice3)

# 결과값 
# A = 2.097, p-value = 0.00002427 
# => 정규성 가정을 만족하지 않음.
