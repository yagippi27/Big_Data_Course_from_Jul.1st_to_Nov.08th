sales=read.csv("D:/workspace/PROJECT/R_project/sales.csv")
head(sales)
## 뒤에 지저분한 자료 제거
library(dplyr)
clean_sales = sales %>%
  select(1:9)

head(clean_sales)

library(caret)

idx = createDataPartition(clean_sales$CATEGORY, p=0.7, list=F)
train_data = clean_sales[idx, ]
test_data = clean_sales[-idx, ]
head(train_data)

## Naive Bayes(Accuracy : 0.9669)
library(e1071)
naive_result = naiveBayes(train_data, train_data$CATEGORY, laplace=1)
naive_pred = predict(naive_result, test_data, type='class')
table(naive_pred, test_data$CATEGORY, dnn = c("Prediction", "Actual"))

confusionMatrix(naive_pred, test_data$CATEGORY)


## Logistic Regression(Accuracy : 0.9091)
library(nnet)
multi_result = multinom(CATEGORY~. , train_data)
multi_pred = predict(multi_result, test_data)
table(multi_pred, test_data$CATEGORY, dnn = c("Prediction", "Actual"))

confusionMatrix(multi_pred, test_data$CATEGORY)


## Decision Tree(Accuracy : 0.8512)
library(rpart)
rpart_result = rpart(CATEGORY~. , train_data)
rpart_pred = predict(rpart_result, test_data, type='class')
table(rpart_pred, test_data$CATEGORY, dnn = c("Prediction", "Actual"))

confusionMatrix(rpart_pred, test_data$CATEGORY)


## Artificial Neural Network(Accuracy : 0.8182)
library(nnet)
train_data_scale = as.data.frame(sapply(train_data[, -2], scale))
test_data_scale = as.data.frame(sapply(test_data[,-2 ], scale))
train_data_scale$CATEGORY = train_data$CATEGORY
test_data_scale$CATEGORY = test_data$CATEGORY
nnet_result = nnet(CATEGORY~. , train_data_scale, size = 3)
nnet_pred = predict(nnet_result, test_data_scale, type = 'class')
table(nnet_pred, test_data$CATEGORY, dnn = c("Prediction", "Actual"))

confusionMatrix(table(nnet_pred, test_data$CATEGORY))


## Support Vector Machine(Accuracy : 0.7603)
library(kernlab)
svm_result = ksvm(CATEGORY~. , train_data, kernel='rbfdot')
svm_pred = predict(svm_result, test_data, type='response')
table(svm_pred, test_data$CATEGORY, dnn = c("Prediction", "Actual"))

confusionMatrix(svm_pred, test_data$CATEGORY)


## Random Forest(Accuracy : 0.9669)
library(randomForest)
rf_result = randomForest(CATEGORY~. , train_data, ntree=500)
rf_pred = predict(rf_result, test_data, type='response')
table(rf_pred, test_data$CATEGORY, dnn = c("Prediction", "Actual"))

confusionMatrix(rf_pred, test_data$CATEGORY)

## 1. Naive Bayes(Accuracy : 0.9669)
## 1. Random Forest(Accuracy : 0.9669)
## 3. Logistic Regression(Accuracy : 0.9091)
## 4. Decision Tree(Accuracy : 0.8512)
## 5. Artificial Neural Network(Accuracy : 0.8182)
## 6. Support Vector Machine(Accuracy : 0.7603)