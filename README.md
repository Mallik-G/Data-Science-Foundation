#Predicting Bike Sharing Demand in Washington DC
by Tommy Ly in fulfillment of MySlideRule’s Data Science Foundation, Project 1

##Section 1. Explore Dataset
*1.1 Independent Variable*
> ```
datetime:   date and hour in "mm/dd/yyyy hh:mm" format
season:     Four categories-> 1 = spring, 2 = summer, 3 = fall, 4 = winter
holiday:    whether the day is a holiday or not (1/0)
workingday: whether the day is neither a weekend nor holiday (1/0)
weather:    Four Categories of weather
            1-> Clear, Few clouds, Partly cloudy, Partly cloudy
            2-> Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist
            3-> Light Snow and Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds
            4-> Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog
temp:       hourly temperature in Celsius
atemp:      "feels like" temperature in Celsius
humidity:   relative humidity
windspeed:  wind speed
```

*1.2 Dependent Variable*
> ```
registered: number of registered user
casual:     number of non-registered user
count:      number of total rentals (registered + casual)
```

*1.3 Initial hypothesis*

> 
+  Hourly trend: People would demand for bike sharing service based on hour block. From my own experience, it will never be a strong relationship if we divided hour into 24hour or 12hour basis but in hour block (e.g: 4-10am, 10am-2pm, 2pm-6pm, etc.)
+ Day-of-week trend: People would use bike more often on weekend, especially on Sunday rather than work day. 
+ Rain: There'd be less ridership on rainy day vs non-rainy day.
+ Registered vs Casual: Riders registered beforehand tend to use bike more often than casual walk-in rider.


##Section 2. Exploratory Data Analysis
*2.1 Categorical variable visualisation*
![Categorical variable boxplot](https://raw.githubusercontent.com/tommyly2010/Data-Science-Foundation/master/Bike Sharing Demand/figures/categorical.png)

*2.2 Numerical variable visualisation*
![Numerical variable boxplot](https://raw.githubusercontent.com/tommyly2010/Data-Science-Foundation/master/Bike Sharing Demand/figures/numerical.png)

*2.3 Insights*
> Based on our initial hypothesis, our visualisation seems to confirm that there is a relationship between hour-of-day and day-of-week factor as well as "weather" factor. However, further feature engineering should be done to properly categorize into hour block and day of week block.

##Section 3. Feature Engineering
> As being demonstrated in the 2-Refine.R code, most of our categorial variable has ben factorize (season, holiday, working day, weather) and "datetime" also has been convereted to proper format of Year-Month-Day-Hour-Minute-Second. 
After refactoring data, we then look at how we can convert the existed variable "datetime" into "day-of-week" and "hour-of-day". Afterward, we create variable "daypart" which basically split hour into three different block. Then, we convert "count", "registered" and  "casual" into log10 basis, hopefully to help our Root Mean Square Later evaluation

##Section 4. Model Implementation

*4.1 Choosing model*
> At first, I used three machine learning techniques: linear regression, decision tree and random forest without tweaking any features and come up with raw RMSLE, the result favoured Random Forest with lowest RMSLE. After careful consideration, I have decided to go ahead and use the Random Forest Model and do 2 models separately for registered & casual users only to combine them later for evaluation through a RMSLE function.

*2.4 Root Mean Square Log Error Evaluation*

> `0.407`

## Section 5. Conclusion
> + A better feature engineering could be implemented, we did not create a separate variable for temperature & humidity. It could be possible that these two variables are affecting the model after a certain threshold. Similarly, in Washington, we can separate hour block differently for summer as well as winter (daylight difference between these 2 seasons).
+ From personal reading, I also noticed people are recommending using PCA to determine which variables are the most important to put in a model and using Generalized Boosting Model for the best results. However, due to time constraints and current limited knowledge, I'd not try to dive into these 2 areas but will try to implement those models in a potential different projects

##References
- [Stanford Machine Learning Class](https://www.coursera.org/course/ml)
- [Random Forest Documentation](https://www.wikiwand.com/en/Random_forest)
- [Random Forests for Classification Trees and Categorical Dependent Variables](http://cogsci.ucmerced.edu/shih/R-randomforest-guide.pdf)
- [MITx-Analytics Edge-Random Forest Lecture](https://www.edx.org/course/analytics-edge-mitx-15-071x-0)
