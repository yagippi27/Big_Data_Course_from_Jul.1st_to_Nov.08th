## Boston 데이터 가져오기
install.packages("MASS")
library(MASS)
head(Boston)
names(Boston)

## Boston 데이터를 데이터 프레임으로 만들기
Boston = as.data.frame(Boston)
head(Boston)

## 랜덤 샘플링 하여 train_data와 test_data로 나눔
idx = sample(1:nrow(Boston), size=nrow(Boston)*0.7, replace= F)
idx
boston_train = Boston[idx, ]
boston_test = Boston[-idx, ]


##### Regression Analysis #####
lm_fit = lm(medv~., data=boston_train)
summary(lm_fit)


## method는 both, backward, forward가 있음
lm_fit2 = step(lm_fit, method='both')
summary(lm_fit2)

## interval=c("none", "confidence", "prediction")
## interval의 기본값은 none이며, 이 경우 신뢰 구간이 계산되지 않는다.
lm_pred = predict(lm_fit2, newdata = boston_test)

## interval을 confidence인 경우, 회귀 계수에 대한 신뢰 구간을 고려하여 
## 종속 변수의 신뢰 구간(confidence interval)을 찾음.
lm_pred95 = predict(lm_fit2, newdata = boston_test, interval='confidence')
lm_pred95

## interval이 prediction인 경우 회귀 계수의 신뢰 구간과 오차항을 고려한 
## 종속 변수의 예측 구간(prediction interval)을 찾는다.
lm_pred99 = predict(lm_fit2, newdata = boston_test, interval='prediction')
lm_pred99


## 오차 검증 해야함 -> lm_fit2에서
par(mfrow=c(2,2))
## 정규성이 높지는 않은 듯함. 그렇게 좋은 데이턴 아니기 때문에 정규성을 맞춰줘야함.
plot(lm_fit2)
shapiro.test(Boston$medv)

## Mean Square Error
## kk는 분산을 의미함. 
kk = mean((lm_pred-boston_test$medv)^2)
kk
## 즉 제곱근이 4.524701인 것은 실제 주택가격 값의 약 $4524 이내에 있다는 것을 의미.
sqrt(kk)


##### Decision Tree #####
install.packages('tree')
library(tree)
tree_fit=tree(medv~. , data=boston_train)
## summary를 했을 때, 1번 항목에
## lstat, rm, crim의 순서는 가장 많은 영향을 끼치는 순서임.
summary(tree_fit)

par(mfrow=c(1,1))
plot(tree_fit)
text(tree_fit, pretty=0)

## 제곱근이 4.1039가 나옴 $4103정도 안에 다 들어와있다는 소리
tree_pred = predict(tree_fit, newdata = boston_test)
kk_t = mean((tree_pred-boston_test$medv)^2)
kk_t
sqrt(kk_t)

##### Decision Tree using rpart #####
library(rpart)
rpart_fit = rpart(medv~., data = boston_train)
# Variable importance
# lstat     rm    indus    crim     nox      zn     dis     age   ptratio   tax     rad 
#   24      18      12      12      11       9       3       3       3       2       1
summary(rpart_fit)

## rpart 시각화
install.packages("rpart.plot")
library(rpart.plot)
?rpart.plot
## rpart.plot(value, digits = 자리수, type = 유형, extra)
rpart.plot(rpart_fit, digits = 3, type = 0, extra = 1, fallen.leaves = F, cex = 1)

rpart_pred = predict(rpart_fit, newdata = boston_test)
kk_rpart = mean((rpart_pred-boston_test$medv)^2)
kk_rpart
## 제곱근이 3.976가 나옴 $3976정도 안에 다 들어와있다는 소리
sqrt(kk_rpart)



##### Artificial Neural Network ###### <-의 제곱근 값이 낮은 이유는 정규화를 했기 때문.
## 정규화 함수 작성
normailze = function(x){
  return((x-min(x))/(max(x)-min(x)))
}
boston_train_norm = as.data.frame(sapply(boston_train, normailze))
boston_test_norm = as.data.frame(sapply(boston_test, normailze))

#####  Artificial Neural Network using nnet #####
library(nnet)
nnet_fit = nnet(medv~., data = boston_train_norm, size = 5)
nnet_pred = predict(nnet_fit, newdata = boston_test_norm, type = 'raw')
kk_nnet =  mean((nnet_pred-boston_test_norm$medv)^2)
kk_nnet
## 제곱근이 0.109가 나옴 $109정도 안에 다 들어와있다는 소리
sqrt(kk_nnet)


##### Artificial Neural Network using neuralnet #####
install.packages("neuralnet")
library(neuralnet)
## 인공 신경망은 독립변수를 직접 표기해야함.
neural_fit = neuralnet(medv~crim+zn+indus+chas+nox+rm+age+dis+rad+tax+ptratio+black+lstat, data= boston_train_norm, hidden = 5 )
neural_pred = compute(neural_fit, boston_test_norm[1:13])
neural_pred
kk_neural = mean((neural_pred$net.result-boston_test_norm$medv)^2)
kk_neural
## 제곱근이 0.097가 나옴 $97정도 안에 다 들어와있다는 소리
sqrt(kk_neural)

plot(neural_fit)


##### Random Forest #####
library(randomForest)
set.seed(1)
rf_fit = randomForest(medv~., data=boston_train, mtry=6, importance=T)
rf_fit
plot(rf_fit)

## %IncMSE는 중요한 정도 rm = 36.6, lstat = 35.3
## IncNodePurity는 불순물이 가장 많이 빠진 node의 수치 lstat = 12590.2568로 가장 많이 불순물이 없음.
importance(rf_fit)

varImpPlot(rf_fit)

rf_pred = predict(rf_fit, newdata = boston_test )
kk_rf = mean((rf_pred-boston_test$medv)^2)
kk_rf
## 제곱근이 2.841가 나옴 $2841정도 안에 다 들어와있다는 소리
sqrt(kk_rf)
