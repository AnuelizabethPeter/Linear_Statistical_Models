# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(gridExtra)
library(recipes)
library(rsample)

# Load the dataset
insurance_data <- read.csv("C:/Users/anu_p/Downloads/medinsur.csv")

# Data Exploration
# Check for Missing Values
missing_values <- sapply(insurance_data, function(x) sum(is.na(x)))
print("Missing Values:")
print(missing_values)

# Summary Statistics
summary_stats <- summary(insurance_data)
print("Summary Statistics:")
print(summary_stats)

# Data Visualization
# Univariate Histograms for Numerical Variables
p1 <- ggplot(insurance_data, aes(x = age)) +
  geom_histogram(binwidth = 2, fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "Age Distribution") +
  theme_minimal()

p2 <- ggplot(insurance_data, aes(x = bmi)) +
  geom_histogram(binwidth = 2, fill = "salmon", color = "black", alpha = 0.7) +
  labs(title = "BMI Distribution") +
  theme_minimal()

p3 <- ggplot(insurance_data, aes(x = children)) +
  geom_histogram(binwidth = 1, fill = "lightgreen", color = "black", alpha = 0.7) +
  labs(title = "Children Distribution") +
  theme_minimal()

p4 <- ggplot(insurance_data, aes(x = charges)) +
  geom_histogram(binwidth = 2000, fill = "gold", color = "black", alpha = 0.7) +
  labs(title = "Charges Distribution") +
  theme_minimal()

# Combine numerical variable plots
grid.arrange(p1, p2, p3, p4, ncol = 2, nrow = 2, top = "Distribution of Numerical Variables")

# Bar plots for Categorical Variables
p1 <- ggplot(insurance_data, aes(x = sex)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Gender Distribution") +
  theme_minimal()

p2 <- ggplot(insurance_data, aes(x = smoker)) +
  geom_bar(fill = "salmon", color = "black") +
  labs(title = "Smoker Distribution") +
  theme_minimal()

p3 <- ggplot(insurance_data, aes(x = region)) +
  geom_bar(fill = "lightgreen", color = "black") +
  labs(title = "Region Distribution") +
  theme_minimal()

# Combine categorical variable plots
grid.arrange(p1, p2, p3, ncol = 2, top = "Distribution of Categorical Variables")

# Box plots for Categorical Variables vs Charges
p1 <- ggplot(insurance_data, aes(x = sex, y = charges)) +
  geom_boxplot(fill = "skyblue", color = "black") +
  labs(title = "Gender vs Charges") +
  theme_minimal()

p2 <- ggplot(insurance_data, aes(x = smoker, y = charges)) +
  geom_boxplot(fill = "salmon", color = "black") +
  labs(title = "Smoker vs Charges") +
  theme_minimal()

p3 <- ggplot(insurance_data, aes(x = region, y = charges)) +
  geom_boxplot(fill = "lightgreen", color = "black") +
  labs(title = "Region vs Charges") +
  theme_minimal()

# Combine box plots
grid.arrange(p1, p2, p3, ncol = 3, top = "Box Plots of Categorical Variables vs Charges")

# Log transform the charges variable
insurance_data$charges <- log(insurance_data$charges + 1)

# Box plots after log transform
p1 <- ggplot(insurance_data, aes(x = sex, y = charges)) +
  geom_boxplot(fill = "skyblue", color = "black") +
  labs(title = "Gender vs Charges") +
  theme_minimal()

p2 <- ggplot(insurance_data, aes(x = smoker, y = charges)) +
  geom_boxplot(fill = "salmon", color = "black") +
  labs(title = "Smoker vs Charges") +
  theme_minimal()

p3 <- ggplot(insurance_data, aes(x = region, y = charges)) +
  geom_boxplot(fill = "lightgreen", color = "black") +
  labs(title = "Region vs Charges") +
  theme_minimal()

# Combine box plots after log transform
grid.arrange(p1, p2, p3, ncol = 3, top = "Box Plots of Categorical Variables vs Charges after log transform")

# Data Preparation for Building Linear Regression Model
X <- subset(insurance_data, select = -c(charges))
y <- insurance_data$charges

# Identify numerical and categorical columns
numerical_cols <- c('age', 'bmi', 'children')
categorical_cols <- c('sex', 'smoker', 'region')

# Preprocessing for numerical data: standardization
numerical_recipe <- recipe(~ ., data = X) %>%
  step_scale(all_of(numerical_cols))

# Preprocessing for categorical data: one-hot encoding
categorical_recipe <- recipe(~ ., data = X) %>%
  step_dummy(all_nominal_predictors())

# Bundle preprocessing for numerical and categorical data
preprocessor <- bake(recipe = merge(numerical_recipe, categorical_recipe), newdata = X)

# Split data into train and test sets
set.seed(0)
split_data <- initial_split(insurance_data, prop = 0.8)
train_data <- training(split_data)
test_data <- testing(split_data)
X_train <- subset(train_data, select = -c(charges))
y_train <- train_data$charges
X_test <- subset(test_data, select = -c(charges))

# Feature Engineering
train_data$age2 <- train_data$age^2
train_data$bmi30 <- ifelse(train_data$bmi >= 30, 1, 0)
test_data$bmi30 <- ifelse(test_data$bmi >= 30, 1, 0)
train_data$bmi30_smoker <- train_data$bmi30 * (train_data$smoker == "yes")
test_data$bmi30_smoker <- test_data$bmi30 * (test_data$smoker == "yes")
test_data$age2 <- test_data$age^2

# Model Building
m1 <- lm(charges ~ age + region + sex + bmi + smoker + children, data = train_data)
summary(m1)

m2 <- lm(charges ~ age + age2 + children + bmi + sex + bmi30*smoker + region, data = train_data)
summary(m2)

# Outlier Detection and Handling
find_outliers <- function(model, threshold = 2) {
  standardized_residuals <- rstandard(model)
  outliers <- abs(standardized_residuals) > threshold
  return(which(outliers))
}

outliers_m1 <- find_outliers(m1)
outliers_m2 <- find_outliers(m2)

# Remove outliers
train_data_cleaned_m1 <- train_data[-outliers_m1, ]
train_data
# Remove outliers for m2
train_data_cleaned_m2 <- train_data[-outliers_m2, ]

# Model Building after Handling Outliers
m1_after <- lm(charges ~ age + region + sex + bmi + smoker + children, data = train_data_cleaned_m1)
summary(m1_after)

m2_after <- lm(charges ~ age + age2 + children + bmi + sex + bmi30*smoker + region, data = train_data_cleaned_m1)
summary(m2_after)

# Diagnostic plots for all models
model_list <- list(m1 = m1, m2 = m2, m1_after = m1_after, m2_after = m2_after)

# Set up a layout for the plots
par(mfrow = c(2, 2))

# Loop through each model and generate diagnostic plots with a title
for (model_name in names(model_list)) {
  model <- model_list[[model_name]]
  plot(model, main = paste("Model", model_name))
}

# AIC and BIC values
AIC_value_m1_after <- AIC(m1_after)
BIC_value_m1_after <- BIC(m1_after)
print(paste("AIC (m1_after):", AIC_value_m1_after))
print(paste("BIC (m1_after):", BIC_value_m1_after))

AIC_value_m2_after <- AIC(m2_after)
BIC_value_m2_after <- BIC(m2_after)
print(paste("AIC (m2_after):", AIC_value_m2_after))
print(paste("BIC (m2_after):", BIC_value_m2_after))

# ANOVA test after handling outliers
anova_result_after <- anova(m1_after, m2_after)
print(anova_result_after)

# Predictions and RMSE for the test dataset
predictions_test_m1 <- predict(m1, newdata = test_data)
prediction_results_test_m1 <- data.frame(Actual = test_data$charges, Predicted = predictions_test_m1)
rmse_test_m1 <- sqrt(mean((prediction_results_test_m1$Actual - prediction_results_test_m1$Predicted)^2))
print(paste("RMSE (Test - m1):", rmse_test_m1))

predictions_test_m2 <- predict(m2, newdata = test_data)
prediction_results_test_m2 <- data.frame(Actual = test_data$charges, Predicted = predictions_test_m2)
rmse_test_m2 <- sqrt(mean((prediction_results_test_m2$Actual - prediction_results_test_m2$Predicted)^2))
print(paste("RMSE (Test - m2):", rmse_test_m2))

predictions_test_m1_after <- predict(m1_after, newdata = test_data)
prediction_results_test_m1_after <- data.frame(Actual = test_data$charges, Predicted = predictions_test_m1_after)
rmse_test_m1_after <- sqrt(mean((prediction_results_test_m1_after$Actual - prediction_results_test_m1_after$Predicted)^2))
print(paste("RMSE (Test - m1_after):", rmse_test_m1_after))

predictions_test_m2_after <- predict(m2_after, newdata = test_data)
prediction_results_test_m2_after <- data.frame(Actual = test_data$charges, Predicted = predictions_test_m2_after)
rmse_test_m2_after <- sqrt(mean((prediction_results_test_m2_after$Actual - prediction_results_test_m2_after$Predicted)^2))
print(paste("RMSE (Test - m2_after):", rmse_test_m2_after))

# Display RMSE values for each model
cat("RMSE (Test - m1):", rmse_test_m1, "\n")
cat("RMSE (Test - m2):", rmse_test_m2, "\n")
cat("RMSE (Test - m1_after):", rmse_test_m1_after, "\n")
cat("RMSE (Test - m2_after):", rmse_test_m2_after, "\n")

