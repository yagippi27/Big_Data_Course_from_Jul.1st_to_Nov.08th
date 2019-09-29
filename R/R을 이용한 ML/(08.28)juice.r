
juice = read.csv("D:/workspace/PROJECT/R_project/(8.23)juice1.csv")
head(juice)
juice$YEAR = substr(juice$YM, 1,4)
juice$MONTH = substr(juice$YM, 5,6)
juice$Count_QTY = juice$QTY/juice$ITEM_CNT
juice
juice1=juice[, c(6,7,8,9,10,13)]

shapiro.test(juice$Count_QTY)

plot(x = juice$MONTH, y = juice$Count_QTY)
plot(x = juice$MAXTEMP, y = juice$Count_QTY, ylim = c(10,60))

head(juice1)


idx = sample(1:nrow(juice1), size=nrow(juice1)*0.7, replace=F)
juice_train = juice1[idx, ]
juice_test = juice1[-idx, ]
juice_train

## RSQ(결정 계수)는 주어진 값을 기준으로 피어슨 상관 계수의 제곱을 구하는 것
## 또한 조정의 정확도를 측정하는 단위이며, 회귀 분석을 만만드는데 사용할 수 있음.
rsq = function(x, y){
  cor(x, y)^2
}

# library(caret)

##1번 시도 ITEM_CNT * PRICE   MAXTEMP *** SALEDAY ***  RAIN_DAY *   HOLIDAY 
##2번 시도 ITEM_CNT . PRICE   MAXTEMP *** SALEDAY ***  RAIN_DAY **  HOLIDAY 
##3번 시도 ITEM_CNT * PRICE . MAXTEMP *** SALEDAY ***  RAIN_DAY **  HOLIDAY .
##4번 시도 ITEM_CNT * PRICE . MAXTEMP *** SALEDAY ***  RAIN_DAY *  HOLIDAY *
##5번 시도 ITEM_CNT * PRICE   MAXTEMP *** SALEDAY ***  RAIN_DAY **  HOLIDAY 

##### 다중 회귀분석 기법 사용 ##### =>평균제곱오차: 9.693173 제곱근: 3.113386
lm.fit = lm(Count_QTY~PRICE+MAXTEMP+SALEDAY+RAIN_DAY+HOLIDAY, data=juice_train)
summary(lm.fit)
confint(lm.fit)

lm.fit2 = step(lm.fit, method="both")
summary(lm.fit2)
lm.pred = predict(lm.fit2, newdata=juice_test)

kk_lm = mean((lm.pred-juice_test$Count_QTY)^2)
kk_lm
sqrt(kk_lm)

rsq(lm.pred, juice_test$Count_QTY)
par(mfrow=c(1, 1))
## plot 만들기
x = seq(1,100)
y = x
plot(lm.pred, juice_test$Count_QTY, xlim=c(20, 45), ylim=c(20, 45))
abline(x,y, col="red")

## 변수 HOLIDAY와 PRICE제거
juice_train_rm_hd_pr = juice_train[, -c(1,5)]
juice_test_rm_hd_pr = juice_test[,-c(1,5)]
lm.fit3 = lm(Count_QTY~., data=juice_train_rm_hd_pr)
summary(lm.fit3)
lm.fit4 = step(lm.fit3, method="both")
lm.pred2 = predict(lm.fit4, newdata=juice_test_rm_hd_pr)


kk_lm2 = mean((lm.pred2-juice_test_rm_hd_pr$Count_QTY)^2)
kk_lm2
sqrt(kk_lm2)

rsq(lm.pred2, juice_test_rm_hd_pr$Count_QTY)


plot(lm.pred2, juice_test_rm_hd_pr$Count_QTY, xlim=c(20, 45), ylim=c(20, 45))
abline(x,y, col="red")


## 변수 HOLIDAY와 PRICE, ITEN_CNT제거
juice_train_rm_hd_pr_ic = juice_train[, -c(1,2,6)]
juice_test_rm_hd_pr_ic = juice_test[,-c(1,2,6)]
lm.fit5 = lm(Count_QTY~., data=juice_train_rm_hd_pr_ic)
summary(lm.fit5)
lm.fit6 = step(lm.fit5, method="both")
lm.pred3 = predict(lm.fit6, newdata=juice_test_rm_hd_pr_ic)


kk_lm3 = mean((lm.pred3-juice_test_rm_hd_pr_ic$Count_QTY)^2)
kk_lm3
sqrt(kk_lm3)

rsq(lm.pred3, juice_test_rm_hd_pr_ic$Count_QTY)


plot(lm.pred3, juice_test_rm_hd_pr_ic$Count_QTY, xlim=c(20, 45), ylim=c(20, 45))
abline(x,y, col="red")



##### 의사결정트리 기법1 using tree ##### =>평균제곱오차: 29.55897 제곱근: 5.436817
library(tree)
tree.fit = tree(Count_QTY~., data = juice_train)
summary(tree.fit)

plot(tree.fit)
text(tree.fit, pretty=0)

tree.pred = predict(tree.fit, newdata = juice_test)
kk_dt =mean((tree.pred-juice_test$Count_QTY)^2)
kk_dt
sqrt(kk_dt)

ggplot(data = juice_test)+
  geom_point(aes(x = PRICE+MAXTEMP+SALEDAY+RAIN_DAY+HOLIDAY, y = Count_QTY))+
  geom_line(aes(x = PRICE+MAXTEMP+SALEDAY+RAIN_DAY+HOLIDAY, y = tree.pred), color = 'blue')+
  geom_segment(aes(x = PRICE+MAXTEMP+SALEDAY+RAIN_DAY+HOLIDAY, y = tree.pred,  yend = y, xend=x))
  scales_y_continous("")

##### 의사결정트리 기법2 using rpart ##### =>평균제곱오차: 36.18341 제곱근: 6.015265
library(rpart)
rpart.fit = rpart(Count_QTY~., data = juice_train)
summary(rpart.fit)

library(rpart.plot)
rpart.plot(rpart.fit, digits=3, type = 0 ,extra = 1, fallen.leaves = F, cex=1)

rpart.pred = predict(rpart.fit, newdata = juice_test)
kk_rp = mean((rpart.pred-juice_test$Count_QTY)^2)
kk_rp  
sqrt(kk_rp)  
  
##### 인공신경망 기법1 using nnet ##### =>평균제곱오차: 0.1001756 제곱근: 0.3165053
normalize = function(x){
  return((x-min(x))/(max(x)-min(x)))
}
juice_train_norm = as.data.frame(sapply(juice_train, normalize))
juice_test_norm = as.data.frame(sapply(juice_test, normalize))

library(nnet)
nnet.fit= nnet(Count_QTY~., data= juice_train_norm, size = 5)
nnet.pred = predict(nnet.fit, newdata=juice_test_norm, type='raw')
kk_nn = mean((nnet.pred-juice_test_norm$Count_QTY)^2)
kk_nn
sqrt(kk_nn)

##### 인공신경망 기법2 using neuralnet ##### =>평균제곱오차: 0.1259835제곱근: 0.3549416
library(neuralnet)
neural.fit = neuralnet(Count_QTY~PRICE+MAXTEMP+SALEDAY+RAIN_DAY+HOLIDAY, data=juice_train_norm, hidden=5)
neural.results = compute(neural.fit, juice_test_norm[1:6])
neural_pred = neural.results$net.result
kk_nl = mean((neural_pred-juice_test_norm$Count_QTY)^2)
kk_nl
sqrt(kk_nl)


##### 앙상블 기법 ##### =>평균제곱오차: 12.84172 제곱근: 3.583534
library(randomForest)
set.seed(1)
rf.fit = randomForest(Count_QTY~., data = juice_train, mtry=5, importance=T)
rf.fit
plot(rf.fit)
importance(rf.fit)
varImpPlot(rf.fit)
rf.pred = predict(rf.fit, newdata = juice_test)
kk_rf = mean((rf.pred-juice_test$Count_QTY)^2)
kk_rf
sqrt(kk_rf)

