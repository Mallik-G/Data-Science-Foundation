# 1.Summarizing data
getwd()
setwd('/Users/tommyly/Documents/MySlideRule/MySlideRule-Data-Science-Foundation/Bike Sharing Demand')
# Read the csv file
bike_train = read.csv("train.csv")
bike_test = read.csv("test.csv")
bike_test[c('casual', 'registered', 'count')] = 0 #reformat data so both are the same
bike_total = rbind(bike_train,bike_test) #cannot combine
# Structure of the dataset
str(bike_train)
str(bike_test)
str(bike_total)
# Statistical summary
summary(bike_train)
#Find missing value
table(is.na(bike_train)) #No N.A value. Awesome!
