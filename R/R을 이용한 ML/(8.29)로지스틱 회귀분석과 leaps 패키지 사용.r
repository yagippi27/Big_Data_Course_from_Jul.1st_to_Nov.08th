setwd("D:/workspace/PROJECT/ML_project")

disease = read.csv("D:/workspace/PROJECT/ML_project/logistic분석/disease.csv")
head(disease)

##### 로지스틱 회귀분석 #####
model13 = glm(disease~., family = binomial(logit), data = disease)
summary(model13)

model14 = glm(disease~age+sector, data = disease, family = binomial(logit))

# Pr(>Chi) = 0.5474 => 독립적인 변수임. 
# 따라서 model14를 사용하겠음.
anova(model13, model14, test = 'Chisq')

table(disease$disease)
31/98

kk = table(disease$disease, model14$fitted.values>0.316)
kk

c(민감도=kk[2,2]/sum(kk[2,]), 
     특이도=kk[1,1]/sum(kk[1,]), 
     에러율=(kk[1,2]+kk[2,1])/sum(kk), 
     정확도=(kk[1,1]+kk[2,2]/sum(kk)))
     
install.packages("Deducer")
library(Deducer)
rocplot(model14)
rocplot(model13)

## caret 패키지 설치

library(caret)
idx = createDataPartition(iris$Species, p=0.7, list=F)
iris_train = iris[idx, ]
iris_test = iris[-idx, ]
table(iris_train$Species)
table(iris_test$Species)

##### desiciontree, naivebayes, randomforest 모델 성능 평가하기 #####
library(rpart)
library(e1071)
library(randomForest)

rpart.iris = rpart(Species~., data= iris_train)
bayes.iris = naiveBayes(Species~., data = iris_train)
rdf.iris = randomForest(Species~., data = iris_train, importance=T)

## type -> class (범주형), randomforest는 종속 변수를 response라고 함?
rpart.pred = predict(rpart.iris, newdata=iris_test, type='class')
bayes.pred = predict(bayes.iris, newdata=iris_test, type='class')
rdf.pred = predict(rdf.iris, newdata = iris_test, type='response')

table(iris_test$Species, rpart.pred)
table(iris_test$Species, bayes.pred)
table(iris_test$Species, rdf.pred)


confusionMatrix(rpart.pred, iris_test$Species, positive = 'versicolor')
confusionMatrix(bayes.pred, iris_test$Species, positive = 'versicolor')
confusionMatrix(rdf.pred, iris_test$Species, positive = 'versicolor')


##### 회귀분석과 leaps 사용하기 #####

## leaps 패키지 설치
install.packages("leaps")
library(leaps)
head(attitude)
cor(attitude)


out = lm(rating~., data=attitude)
summary(out)


## forward -> 유의미한 순서대로 추가하기
## backward -> 유의미하지 않은 순서대로 뺴기
## both -> forward, backward 동시에 수행하기

## lm에서 both 설정(Adjusted R-squared:  0.6864)
out2 = step(out, direction = 'both')
summary(out2)

leaps = regsubsets(rating~., data = attitude, nbest = 5)
summary(leaps)

## scle = bic(Adjusted R-squared:  0.6699)
plot(leaps, scales = 'bic')
out_bic = lm(rating~complaints, data = attitude)
summary(out_bic)

## scale = cp(Adjusted R-squared:  0.6864)
plot(leaps, scale='Cp')
out_cp = lm(rating~complaints+learning, data = attitude)
summary(out_cp)

## scale = adjr2(Adjusted R-squared:  0.6939)
plot(leaps, scale='adjr2')
out_adjr2 = lm(rating~complaints+learning+advance, data=attitude)
summary(out_adjr2)
