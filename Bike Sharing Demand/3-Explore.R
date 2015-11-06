#3.Exploratory Data Analysis 

# by categorical variable
layout(matrix(c(1,1,2,3,4,5),2,3,byrow=FALSE)) #
boxplot(bike_train$count, main="count")
boxplot(bike_train$count ~ bike_train$weather, main="weather")
boxplot(bike_train$count ~ bike_train$season, main="season")
boxplot(bike_train$count ~ bike_train$holiday, main="holiday")
boxplot(bike_train$count ~ bike_train$workingday, main="working day")

#by numerical variable
par(mfrow=c(2,2))
par(mar = rep(2, 4))
hist(bike_train$humidity, main = "humidity")
hist(bike_train$temp, main = "temperature")
hist(bike_train$atemp, main = "feel temperature")
