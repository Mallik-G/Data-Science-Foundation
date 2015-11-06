# 7.1 Random Forest - Split Model for 2 Casual & Registered. 
# Install rpart library
install.packages('randomForest')
library(randomForest)

# Split the data
library(caTools)
set.seed(3000)
spl = sample.split(bike_train$count, SplitRatio = 0.7)
Train = subset(bike_train, spl==TRUE)
Test = subset(bike_train, spl==FALSE)

#Create log10 for casual & registered

Train$casual_log10=log10(Train$casual+1)
Train$registered_log10=log10(Train$registered+1)

#Build random forest model based on log10 value
BikeForest_Registered = randomForest(registered_log10 ~ season + weather + temp + humidity + windspeed + hour + sunday + daypart + sunday + holiday + workingday,data=Train[,-c(10)], ntree=250) 

BikeForest_Casual = randomForest(casual_log10 ~ season + weather + temp + humidity + 
                                   windspeed + hour + sunday + daypart + sunday + holiday + workingday,data=Train[,-c(11)], ntree=250) 

PredictForest_Registered = predict(BikeForest_Registered, newdata = Test)

PredictForest_Casual = predict(BikeForest_Casual, newdata = Test)

PredictForest_Combine <- round(10^PredictForest_Registered + 10^PredictForest_Casual -2)

#Create evaluation function 
RMSLE_Evaluation <- function (data, pred) {
  return(sqrt(1/nrow(data)*sum((log(pred+1)-log(data$count+1))^2)))}

#Evaluate model
RMSLE_Evaluation(Test,PredictForest_Combine)
