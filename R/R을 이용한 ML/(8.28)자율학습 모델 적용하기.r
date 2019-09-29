## iris 데이터 불러오기
iris2 = iris[,1:4]
head(iris2)


##### K-평균 클러스터링 분석 수행하기 #####

## km.out.withness는 군집 내 제곱합, km.out.between는 군집 간 제곱합
km.out.withness = c()
km.out.between = c()
## ii는 군집 개수
ii =c()

for (i in 2:7){
  set.seed(1)
  km.out = kmeans(iris2, centers = i)
  km.out.withness[i-1] = km.out$tot.withinss
  km.out.between[i-1] = km.out$betweenss
  ii=c(ii, i)
}
df = data.frame(ii, km.out.withness, km.out.between)

## 군집이 3일 때가 가장 적합함. 엘보우 점
par(mfrow=c(1,2))
plot(df$ii, df$km.out.withness, type = 'o')
plot(df$ii, df$km.out.between, type = 'o')

km.out.k3 = kmeans(iris2, centers=3)
km.out.k3$centers
km.out.k3$cluster
km.out.k3$size
table(km.out.k3$cluster, iris$Species)

## pch = 찍히는 마크 모양
par(mfrow=c(1,2))
plot(iris2[,1:2], col=km.out.k3$cluster, pch=ifelse(km.out.k3$cluster==1, 16, ifelse(km.out.k3$cluster==2, 17, 18)), cex=2)
points(km.out.k3$centers, col=1:3, pch=16:18, cex=5)

plot(iris[,1:2], col=iris$Species, pch=ifelse(iris$Species=="versicolor", 16, ifelse(iris$Species=='setosa', 17, 18)), cex=2)


par(mfrow=c(1,1))

##### 다변량 분석 #####
## crime 데이터 가져오기
crime = read.csv("http://datasets.flowingdata.com/crimeRatesByState-formatted.csv")
head(crime)

## 인덱스의 숫자를 없애고 주 이름으로 놓았음.
rownames(crime) = crime[, 1]
crime

## star 그래프 설정
stars(crime[, 2:8])
## star 그래프 라벨 설정
stars(crime[, 2:8], flip.labels = FALSE)
## star 그래프 범례 설정
stars(crime[, 2:8], flip.labels = FALSE, key.loc = c(1,20))
## star 그래프 색깔 설정
stars(crime[, 2:8], flip.labels = FALSE, key.loc = c(1,20), draw.segments = TRUE)

## 체르노프 페이스 설치 및 실행
install.packages("aplpack")
library(aplpack)
faces(crime[,2:8], face.type = 2)


## education 데이터 가져오기
education = read.csv("http://datasets.flowingdata.com/education.csv")
head(education)
str(education)

library(lattice)
parallel(education[, 2:7], horizontal.axis = FALSE, col = 1)
summary(education$reading)
color = education$reading >523
color
color + 1
parallel(education[,2:7], horizontal.axis = FALSE, col = color +1)

## baseball 데이터 가져오기기
data = read.csv("D:/workspace/PROJECT/ML_project/20140528_baseball.csv")
head(data)

model = prcomp(data[,2:6], scale. = T)
summary(model)
plot(model)
biplot(model)
rownames(data) = data[,1]
data
model=prcomp(data[, 2:6], scale=T)
biplot(model)

###### 주성분 분석 실습하기 ######
head(USArrests)
pc1 = princomp(USArrests, cor=T)
summary(pc1)
plot(pc1, type='l')
pc1$center
pc1$scale
pc1$loadings
pc1$scores


plot(pc1$scores[, 1], pc1$scores[,2], xlab = 'z1', ylab = 'z2')
## 가운데 선 회색으로 만들기
abline(v=0, h=0, col='grey')
biplot(pc1, cex=0.7)
## 가운데 선 빨간색으로 만들기
abline(v=0, h=0, col='red')

##### 연관성 분석 실습하기#####
install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)
data(Groceries)
data(package = 'arules')

Groceries
inspect(Groceries[1:10])
summary(Groceries)

sort(itemFrequency(Groceries, type='absolute'), decreasing = T)
round(sort(itemFrequency(Groceries, type='relative'), decreasing = T), 3)
itemFrequencyPlot(Groceries, topN=10, type='absolute')
itemFrequencyPlot(Groceries, topN=10, type='relative')

?itemFrequencyPlot

## 실제 연관성 분석 시작
apriori(Groceries)
result_rules = apriori(Groceries, parameter=list(support=0.005, confidence=0.5, minlen=2))
summary(result_rules)
inspect(result_rules[1:5])

rules_lift = sort(result_rules, by='lift', decreasing = T)
inspect(rules_lift[1:5])

rules_conf = sort(result_rules, by='confidence', decreasing = T)
inspect(rules_conf[1:5])

milk_rule = subset(rules_lift, items %in% 'whole milk') 
milk_rule
inspect(milk_rule[1:5])

rhs.milk_rule = subset(rules_lift, rhs %in% "whole milk")
rhs.milk_rule
inspect(milk_rule[1:5])

wholemilk_rule = apriori(Groceries, parameter = list(support=0.005, confidence=0.5, minlen=2), appearance=list(default=1hs, rhs = 'whole milk'))
                         