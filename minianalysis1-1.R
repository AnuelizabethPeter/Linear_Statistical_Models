setwd("~/Linear statistics model analysis")

#creating a data frame
data <- read.csv("earnings.csv")
data <- data[!is.na(data$education), ]
View(data)
num_rows <- nrow(data)
print(num_rows)






male_data <- subset(data, male == 1)
female_data <- subset(data, male == 0)


hist(male_data$earn,xlab="Earnings of Males",ylab ="Frequency" ,col = "#66C2A5", main = "Histogram of Earnings for Males")
hist(female_data$earn,xlab="Earnings of Females",ylab="Frequency", col = "#E78AC3", main ="Histogram of Earnings for Females")  




correlation_coefficient1 <- cor(data$age, data$earn)
correlation_coefficient1

correlation_coefficient2 <- cor(data$education, data$earn)
correlation_coefficient2



plot(data$education, data$earn, xlab = "Education", ylab = "Earnings", main = "Scatter Plot with Regression Line")


mm1<-lm(earn ~ education,data = data)
abline(lm(earn ~ education,data=data)) 
summary(mm1)


data$earn_log <- log(data$earn)


# Check for missing or infinite values in earn_log
any_missing <- any(is.na(data$earn_log) | !is.finite(data$earn_log))

# If there are missing or infinite values, remove those rows
if (any_missing) {
  data <- na.omit(data)
}

# Fit the linear model
mm2 <- lm(earn_log ~ education, data = data)

# Plot the scatter plot with the regression line
plot(data$education, data$earn_log, xlab = "Education", ylab = "Log Earnings", main = "Scatter Plot with Regression Line")
abline(mm2, col = "red")



ggplot(data, aes(x = education, y = earn)) +
  geom_point() +
  labs(x = "Education Level", y = "Earnings", title = "Scatter Plot of Education vs Earnings")

# Linear regression model
mm1 <- lm(earn ~ education, data = data)

# Add the regression line to the ggplot
ggplot(data, aes(x = education, y = earn)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Add linear regression line
  labs(x = "Education Level", y = "Earnings", title = "Scatter Plot of Education vs Earnings")







mm1 <- lm(earn ~ education, data = data)
plot(mm1, which = 1)



mm2 <- lm(earn_log ~ education, data = data)
plot(mm2, which = 1)

# log transformation
data$earn_log <- log(data$earn)
plot(data$education,data$earn_log,xlab="Education Level ",ylab="Earnings",main = " Plot of Log tranform(Earnings) and Education")


ggplot(data, aes(x = education, y = earn)) +
  geom_point() +
  labs(x = "Education Level", y = "Earnings", title = "Scatter Plot of Education vs Earnings")





subset_data <- subset(data, earn > 0)
print(subset_data)
plot(subset_data$education,subset_data$earn_log,xlab="Education ",ylab=" log transformation of earnings")
mm2 <- lm(earn_log ~ education, data = subset_data)
abline(lm(earn_log~education,data=subset_data))
summary(mm2)

mm2 <- lm(earn_log ~ education, data = subset_data)
plot(mm2, which = 1)


# Identify outliers using the IQR method
qnt <- quantile(data$education, c(0.25, 0.75))
iqr <- qnt[2] - qnt[1]
threshold <- 1.5
outliers <- which(data$education < (qnt[1] - threshold * iqr) | data$education > (qnt[2] + threshold * iqr))

# Replace outliers with the mean
data$education[outliers] <- mean(data$education, na.rm = TRUE)
boxplot(data$education)

subset_data <- subset(data, earn > 0)
print(subset_data)
plot(subset_data$education,subset_data$earn_log,xlab="Education ",ylab=" log transformation of earnings")
mm2 <- lm(earn_log ~ education, data = subset_data)
abline(lm(earn_log~education,data=subset_data))
summary(mm2)


mm2 <- lm(earn_log ~ education, data = subset_data)
plot(mm2, which = 1)




length(data)
outliers <- boxplot(data$earn)$out
length(outliers)
print(outliers)
data_no_outlier <- data[!data$earn %in% outliers, ]
print(data_no_outlier)
print(length(data$earn))
print(length(data_no_outlier$earn))
subset_data1 <- subset(data_no_outlier, earn > 0)
plot(subset_data1$education,subset_data1$earn_log,xlab="Education ",ylab=" log transformation of earnings")

mm3 <- lm(earn_log ~ education, data = subset_data1)
abline(lm(earn_log~education,data=subset_data1))
summary(mm3)







#Residual plot for simple model
residuals <- resid(mm1)
plot(fitted(mm1), residuals, xlab = "Fitted Values", ylab = "Residuals", main = "Residual Plot")
abline(h = 0, col = "red")
mean_residuals <- mean(residuals)
print(mean_residuals)

# Residual plot for transformed earnings

residuals1 <- resid(mm2)
plot(fitted(mm2), residuals1, xlab = "Fitted Values", ylab = "Residuals of transoformed model", main = "Tranformation model -Residual Plot")
abline(h = 0, col = "red")
mean_residuals1 <- mean(residuals1)
print(mean_residuals1)

length(subset_data)
outliers <- boxplot(subset_data$earn)$out
length(outliers)
print(outliers)
data_no_outlier <- data[!data$earn %in% outliers, ]
print(data_no_outlier)
print(length(data$earn))
print(length(data_no_outlier$earn))
subset_data1 <- subset(data_no_outlier, earn > 0)
plot(subset_data1$education,subset_data1$earn_log,xlab="Education ",ylab=" log transformation of earnings")

mm3 <- lm(earn_log ~ education, data = subset_data1)
abline(lm(earn_log~education,data=subset_data1))
summary(mm3)




correlation_matrix <- cor(data)

# Display the correlation matrix
print(correlation_matrix)



length(data)
## [1] 150

boxplot(data, plot = FALSE)$out
## [1] 4.4 4.1 4.2 2.0

outliers <- boxplot(data, plot = FALSE)$out
data_no_outlier <- data[-which(data %in% outliers)] 

boxplot(data_no_outlier, plot = FALSE)$out
## numeric(0)

length(data_no_outlier)

# pair wise association
pairs(~ height + weight + tense + angry + age, data = data)
pairs(~ age + education, data = data)


correlation <- cor(data$earn, data$education)
print(paste("Correlation coefficient:", correlation))



# Two separate regression model for subset of data for male and female
subset_data <- subset(female_data, earn > 0)

subset_data$earn_log <- log(subset_data$earn)

# two subsets: one for men and one for women
subset_men <- subset(subset_data, male == 1)
subset_women <- subset(subset_data, male == 0)



pairs(~ earn + education, data = data)

any(is.infinite(subset_data$earn_log))

count_inf_earn_log <- sum(is.infinite(female_data$earn_log))
count_inf_earn_log

mean_earn_log <- mean(subset_data$earn_log[is.finite(subset_data$earn_log)], na.rm = TRUE)
mean_earn_log
subset_data$earn_log[!is.finite(subset_data$earn_log)] <- mean_earn_log


plot(subset_data$education, subset_data$earn_log, col = "blue" , main = "Scatter Plot of Log trasnformed model earnings - education", xlab = "Education", ylab = "Log Earn")


mm2 <- lm(earn_log ~ education, data = subset_data)
abline(lm(earn_log~education,data=subset_data))
abline(mm2, col = "black", lwd = 2)
summary(mm2)



model_age <- lm(earn ~ age, data = data)

# Summarize the model
summary(model_age)




