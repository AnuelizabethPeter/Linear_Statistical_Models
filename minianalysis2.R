data <- read.csv("~/Downloads/earnings.csv")

# Assuming 'data' is your dataset containing columns 'earn' (earnings) and 'gender'

# Filter the data for males
male_data <- subset(data, male == 1)

# Subsetting data based on ethnicity categories
white_data <- subset(male_data, ethnicity == "White")  # Subset for White ethnicity
black_data <- subset(male_data, ethnicity == "Black")  # Subset for non-White (assuming 0 represents non-White)
others_data <- subset(male_data, ethnicity =="Hispanic") # Subset for other ethnicities

# Viewing the structure or summary of each subsetted dataset
 # Structure of data for other ethnicities
# Fit Model 1 (simpler model)
model1 <- lm(earn ~ education, data = white_data)

# Fit Model 2 (more complex model with additional predictors)
model2 <- lm(earn ~ education + age + walk , data = white_data)

# Perform partial F-test to compare the two models
anova_test <- anova(model1, model2)

# View the partial F-test results
print(anova_test)

model1_residuals = model1$residuals
hist(model1_residuals)
model2_residuals = model2$residuals
hist(model2_residuals)

# Plot the residuals
qqnorm(model1_residuals)
# Plot the Q-Q line
qqline(model1_residuals)

# Plot the residuals
qqnorm(model2_residuals)
# Plot the Q-Q line
qqline(model2_residuals)


# Fit Model 1 (simpler model)
model11 <- lm(earn ~ education, data = black_data)

# Fit Model 2 (more complex model with additional predictors)
model12 <- lm(earn ~  education + age + walk + exercise, data = black_data)

# Perform partial F-test to compare the two models
anova_test <- anova(model11, model12)

# View the partial F-test results
print(anova_test)
model11_residuals = model11$residuals
hist(model11_residuals)
model12_residuals = model22$residuals
hist(model12_residuals)

# Plot the residuals
qqnorm(model11_residuals)
# Plot the Q-Q line
qqline(model11_residuals)

# Plot the residuals
qqnorm(model12_residuals)
# Plot the Q-Q line
qqline(model12_residuals)
# Fit Model 1 (simpler model)
model21 <- lm(earn ~ education, data = others_data)

# Fit Model 2 (more complex model with additional predictors)
model22 <- lm(earn ~ education + age + walk + exercise, data = others_data)

# Perform partial F-test to compare the two models
anova_test <- anova(model21, model22)

# View the partial F-test results
print(anova_test)
model21_residuals = model21$residuals
hist(model21_residuals)
model22_residuals = model22$residuals
hist(model22_residuals)

# Plot the residuals
qqnorm(model21_residuals)
# Plot the Q-Q line
qqline(model21_residuals)

# Plot the residuals
qqnorm(model22_residuals)
# Plot the Q-Q line
qqline(model22_residuals)
female_data <- subset(data, male == 0)

# Subsetting data based on ethnicity categories
white_data_female<- subset(female_data, ethnicity == "White")  # Subset for White ethnicity
black_data_female <- subset(female_data, ethnicity == "Black")  # Subset for non-White (assuming 0 represents non-White)
others_data_female<- subset(female_data, ethnicity =="Hispanic") # Subset for other ethnicities


# Fit Model 1 (simpler model) 
modelf1 <- lm(earn ~  education, data = white_data_female)

# Fit Model 2 (more complex model with additional predictors)
modelf2 <- lm(earn ~ education + age + walk  ,data= white_data_female)

# Perform partial F-test to compare the two models
anova_test <- anova(modelf1, modelf2)

# View the partial F-test results
print(anova_test)
modelf1_residuals = modelf1$residuals
hist(modelf1_residuals)
modelf2_residuals = modelf2$residuals
hist(modelf2_residuals)

# Plot the residuals
qqnorm(modelf1_residuals)
# Plot the Q-Q line
qqline(modelf1_residuals)

# Plot the residuals
qqnorm(modelf2_residuals)
# Plot the Q-Q line
qqline(modelf2_residuals)
# Fit Model 1 (simpler model)
modelf11 <- lm(earn ~  education, data = black_data_female)

# Fit Model 2 (more complex model with additional predictors)
modelf12 <- lm(earn ~ education + age + walk + exercise, data = black_data_female)

# Perform partial F-test to compare the two models
anova_test <- anova(modelf11, modelf12)

# View the partial F-test results
print(anova_test)
modelf11_residuals = modelf11$residuals
hist(modelf11_residuals)
modelf12_residuals = modelf12$residuals
hist(modelf12_residuals)

# Plot the residuals
qqnorm(modelf11_residuals)
# Plot the Q-Q line
qqline(modelf11_residuals)

# Plot the residuals
qqnorm(modelf12_residuals)
# Plot the Q-Q line
qqline(modelf12_residuals)
# Fit Model 1 (simpler model)
modelf21 <- lm(earn ~  education, data = others_data_female)

# Fit Model 2 (more complex model with additional predictors)
modelf22 <- lm(earn ~  education + age + walk + exercise, data = others_data_female)

# Perform partial F-test to compare the two models
anova_test <- anova(modelf21, modelf22)
modelf21_residuals = modelf21$residuals
hist(modelf21_residuals)
modelf22_residuals = modelf22$residuals
hist(modelf22_residuals)

# Plot the residuals
qqnorm(modelf21_residuals)
# Plot the Q-Q line
qqline(modelf21_residuals)

# Plot the residuals
qqnorm(modelf22_residuals)
# Plot the Q-Q line
qqline(modelf22_residuals)
# Load required libraries
library(ggplot2)

# Assuming 'data' is your dataset
# Boxplots
par(mfrow = c(2, 3))  # Set up a 2x3 grid for boxplots
boxplot(data$earnings, main = "Earnings")
boxplot(data$age, main = "Age")
boxplot(data$education, main = "Education")
boxplot(data$height, main = "Height")
boxplot(data$weight, main = "Weight")
boxplot(data$walk, main = "Walk")

# Assuming 'model' is your linear regression model
# Replace 'model' with the name of your actual linear regression model

# Predicted values (fitted values)
fitted_values <- predict(model1)

# Residuals from the model
residuals <- resid(model1)

# Create a scatterplot of residuals vs fitted values
plot(fitted_values, residuals,
     xlab = "Fitted values*malewhite(education)",
     ylab = "Residuals",
     main = "Residuals vs Fitted")
# Assuming 'model' is your linear regression model
# Replace 'model' with the name of your actual linear regression model

# Predicted values (fitted values)
fitted_values <- predict(model2)

# Residuals from the model
residuals <- resid(model2)

# Create a scatterplot of residuals vs fitted values
plot(fitted_values, residuals,
     xlab = "Fitted values(education,walk,age)",
     ylab = "Residuals",
     main = "Residuals vs Fitted")
# Assuming 'model' is your linear regression model
# Replace 'model' with the name of your actual linear regression model

# Predicted values (fitted values)
fitted_values <- predict(model12)

# Residuals from the model
residuals <- resid(model12)

# Create a scatterplot of residuals vs fitted values
plot(fitted_values, residuals,
     xlab = "Fitted values(maleblack(edu)",
     ylab = "Residuals",
     main = "Residuals vs Fitted")
# Assuming 'model' is your linear regression model
# Replace 'model' with the name of your actual linear regression model

# Predicted values (fitted values)
fitted_values <- predict(model21)

# Residuals from the model
residuals <- resid(model22)

# Create a scatterplot of residuals vs fitted values
plot(fitted_values, residuals,
     xlab = "Fitted values",
     ylab = "Residuals",
     main = "Residuals vs Fitted")

