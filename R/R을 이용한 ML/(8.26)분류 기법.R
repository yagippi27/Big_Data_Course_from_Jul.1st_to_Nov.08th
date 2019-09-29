iris
names(iris)
table(iris$Species)
head(iris)
idx = sample(1:nrow(iris), size = nrow(iris)*0.7, replace=F)
iris_train = iris[idx, ]
iris_test = iris[-idx,]

## iris_train, iris_test 데이터의 Species는 딱 나눠지지 않음. 
?sample
dim(iris_train)
dim(iris_test)
table(iris_train$Species)
table(iris_test$Species)



## caret 패키지 설치하여 createDataPartition를 사용.
install.packages("caret")
library(caret)

# train.idx에는 iris의 번호가 나옴.
train.idx = createDataPartition(iris$Species, p=0.7, list=F)
iris_train = iris[train.idx, ]
iris_test = iris[-train.idx, ]
dim(iris_train)
dim(iris_test)

## K-Nearest Neighbor 실습 1

like = read.csv("D:/workspace/PROJECT/ML_project/like.csv")
### label => 1타입(마음에 드는 사람), 2타입(호감만 있는 사람), 3타입(평범한 사람)
like
colnames(like) = c('talk', 'book', 'trip', 'school', 'tall', 'skin', 'muscle', 'label')
like

test = data.frame(talk = 70, book =50, trip = 30, school=70, tall = 70, skin = 40, muscle = 50 )

library(class)
train = like[, -8]
group = like[, 8]
knnpred1 = knn(train, test, group, k=3, prob=T)
knnpred2 = knn(train, test, group, k=4, prob=T)
knnpred1
knnpred2

## K-Nearest Neighbor 실습 2

buy = read.csv("D:/workspace/PROJECT/ML_project/buy.csv")
buy
colnames(buy) = c('age', 'pay', 'yes_or_not')
test = data.frame(age = 44, pay=400)

train = buy[, -3]
group = buy[,3]
knnpred1 = knn(train, test, group, k = 3, prob = T)
knnpred2 = knn(train, test, group, k = 4, prob = T)
knnpred1
knnpred2

## Naive Bayes 실습
install.packages('e1071')
library(e1071)
library(caret)
### caret library 활용
idx = createDataPartition(iris$Species, p=0.7 , list=F)
train_iris = iris[idx, ]
test_iris = iris[-idx, ]
table(train_iris$Species)
table(test_iris$Species)  

## Naive Bayes 적용
nb_default = naiveBayes(iris_train, iris_train$Species, laplace = 1)
default_pred = predict(nb_default, iris_test, type = 'class')
table(default_pred, test_iris$Species, dnn =c("Prediction", "Actual"))

# caret 패키지의 confusionMatrix 함수를 이용한 혼동행렬 도출
confusionMatrix(default_pred, iris_test$Species)
  

## 다항 로지스틱 회귀를 사용하기 위한 nnet 패키지 로딩
library(nnet)
multi.result = multinom(Species~., iris_train)
multi.pred = predict(multi.result, iris_test)
table(multi.pred, iris_test$Species, dnn = c("Prediction", "Actual"))

# caret 패키지의 confusionMatrix 함수를 이용한 혼동행렬 도출
confusionMatrix(multi.pred, iris_test$Species)


train.idx = createDataPartition(iris$Species, p=0.7, list=F)
iris_train = iris[train.idx, ]
iris_test = iris[-train.idx, ]
dim(iris_train)
dim(iris_test)

## ~ = 모든 종속변수 . = 모든 독립변수
## decision tree method
library(rpart)
rpart_rt = rpart(Species~., iris_train)
rpart_rt
rpart_pred = predict(rpart_rt, iris_test, type='class')
table(rpart_pred, iris_test$Species)

confusionMatrix(rpart_pred, iris_test$Species, dnn = c('Prediction', 'Acutual'))

## Artifical Neural Network Model
library(nnet)
## 표준화된 데이터
iris_train_scale = as.data.frame(sapply(iris_train[, -5], scale))
head(iris_train_scale)
iris_test_scale = as.data.frame(sapply(iris_test[-5], scale))
head(iris_test_scale)
iris_train_scale$Species=iris_train$Species
iris_test_scale$Species = iris_test$Species
head(iris_train_scale)
nnet_result = nnet(Species~., iris_train_scale, size =3)
nnet_pred = predict(nnet_result, iris_test_scale, type='class')
table(nnet_pred, iris_test$Species)

class(nnet_pred)
# confusionMatrix에서 "Error: `data` and `reference` should be factors with the same levels. "
# 라는 오류가 떠서 안에 table을 넣어서 작성함. 
confusionMatrix(table(nnet_pred, iris_test$Species))
?class



## Support Vector Machine(지지 벡터 머신)
install.packages("klaR")
install.packages("kernlab")
library(kernlab)

svm_result = ksvm(Species~.,  data=iris_train, kernel='rbfdot')
svm_pred = predict(svm_result, iris_test, type='response')
table(svm_pred, iris_test$Species)
confusionMatrix(svm_pred, iris_test$Species)


## Random Forest Method(랜덤 포레스트 기법)

install.packages("randomForest")
library(randomForest)
rf_result = randomForest(Species~. , iris_train, ntree=500)
rf_pred = predict(rf_result, iris_test, type = 'response')
table(rf_pred, iris_test$Species)
confusionMatrix(rf_pred, iris_test$Species)
