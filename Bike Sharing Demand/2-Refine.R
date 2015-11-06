#4.Reformatting data

bike_train$season <- factor(bike_train$season, c(1,2,3,4), ordered=FALSE)
bike_train$holiday <- factor(bike_train$holiday, c(0,1), ordered=FALSE)
bike_train$workingday <- factor(bike_train$workingday, c(0,1), ordered=FALSE)
bike_train$weather <- factor(bike_train$weather, c(4,3,2,1), ordered=TRUE)
# set datetime ####
bike_train$datetime <- as.POSIXct(bike_train$datetime, format="%Y-%m-%d %H:%M:%S")
str(bike_train) #check if categorical have switched to factorial data

bike_test$season <- factor(bike_test$season, c(1,2,3,4), ordered=FALSE)
bike_test$holiday <- factor(bike_test$holiday, c(0,1), ordered=FALSE)
bike_test$workingday <- factor(bike_test$workingday, c(0,1), ordered=FALSE)
bike_test$weather <- factor(bike_test$weather, c(4,3,2,1), ordered=TRUE)
# set datetime ####
bike_test$datetime <- as.POSIXct(bike_test$datetime, format="%Y-%m-%d %H:%M:%S")
str(bike_test) #check if categorical have switched to factorial data

# 4.1 Feature Engineering

#create time column by substring out timestamp
bike_train$time <- substring(bike_train$datetime,12,20)
bike_test$time <- substring(bike_test$datetime,12,20)
str(bike_train)

#create day of week column
bike_train$day <- weekdays(as.Date(bike_train$datetime))
bike_train$day <- as.factor(bike_train$day)
bike_test$day <- weekdays(as.Date(bike_test$datetime))
bike_test$day <- as.factor(bike_test$day)
str(bike_train)

#create Sunday variable
bike_train$sunday[bike_train$day == "Sunday"] <- "1"
bike_train$sunday[bike_train$day != "1"] <- "0"

bike_test$sunday[bike_test$day == "Sunday"] <- "1"
bike_test$sunday[bike_test$day != "1"] <- "0"

#convert to factor
bike_train$sunday <- as.factor(bike_train$sunday)
bike_test$sunday <- as.factor(bike_test$sunday)
str(bike_train)

#convert time and create $hour as integer to evaluate for daypart
bike_train$hour<- as.numeric(substr(bike_train$time,1,2))
bike_test$hour<- as.numeric(substr(bike_test$time,1,2))

#create daypart column, default to 4 to make things easier for ourselves
bike_train$daypart <- "4"
bike_test$daypart <- "4"


#4AM - 10AM = 1
bike_train$daypart[(bike_train$hour < 10) & (bike_train$hour > 3)] <- 1
bike_test$daypart[(bike_test$hour < 10) & (bike_test$hour > 3)] <- 1


#11AM - 3PM = 2
bike_train$daypart[(bike_train$hour < 16) & (bike_train$hour > 9)] <- 2
bike_test$daypart[(bike_test$hour < 16) & (bike_test$hour > 9)] <- 2


#4PM - 9PM = 3
bike_train$daypart[(bike_train$hour < 22) & (bike_train$hour > 15)] <- 3
bike_test$daypart[(bike_test$hour < 22) & (bike_test$hour > 15)] <- 3

#Convert daypart to factor
bike_train$daypart <- as.factor(bike_train$daypart)
bike_test$daypart <- as.factor(bike_test$daypart)

#Convert hour back to factor
bike_train$hour <- as.factor(bike_train$hour)
bike_test$hour <- as.factor(bike_test$hour)
