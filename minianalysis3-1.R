nydata <-read.csv("C:/Users/anu_p/Downloads/AirBnB_NYCity_2019.csv")
nydata <- data.frame(nydata)

data <-subset(nydata,room_type=="Entire home/apt")
summary(data)
head(data)
str(data)
qqnorm(data$price)
qqline(data$price)

# Install ggplot2 
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

library(ggplot2)
hist(data$availability_365, main = "Distribution of availability", xlab = "availability_365")
hist(data$price, main = "Distribution of Price", xlab = "Price")
boxplot(nydata$minimum_nights, main = "Distribution of Minimum Nights")
#categorical variables
table(data$neighbourhood_group)
table(data$room_type)

#missing data
#colSums(is.na(data))
#mean replaced
#data$reviews_per_month[is.na(data$reviews_per_month)] <- mean(data$reviews_per_month, na.rm = TRUE)
#colSums(is.na(data))
# PREPROCESSING THE DATASET
# finding the missing values in the data set
missing_values <- is.na(data)
missing_counts <- colSums(missing_values)
missing_counts

# the missing values are only in the column "reviews_per_month"
# imputation of the missing values with the mean of the missing values in the column "reviews_per_month"
data = transform(data, reviews_per_month = ifelse(is.na(reviews_per_month), mean(reviews_per_month, na.rm=TRUE), reviews_per_month))
# verifying  the columns once again 
missing_values <- is.na(data)
missing_counts <- colSums(missing_values)
missing_counts
#Identify and handle outliers in numerical variables.
boxplot(data$price, main = "Boxplot of Price")
# Assuming 'data' is your dataframe
num_cols <- c("price", "minimum_nights", "number_of_reviews", "reviews_per_month", "calculated_host_listings_count")

# Identify outliers using IQR
outliers <- sapply(data[, num_cols], function(x) {
  qnt <- quantile(x, c(0.25, 0.75), na.rm = TRUE)
  H <- 1.5 * IQR(x, na.rm = TRUE)
  x < (qnt[1] - H) | x > (qnt[2] + H)
})

# Omit rows with outliers
data <- data[!rowSums(outliers), ]
boxplot(data$price, main = "Boxplot of Price")
# Reset row indices if needed
qqnorm(data$price)
qqline(data$price)


# First we'll look at the neighbourhood groups, and where Airbnbs are most commonly found. We'll also look at how they are priced in each neighbourhood group.

# Load necessary libraries
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
library(ggplot2)

# Create a count plot
ggplot(data, aes(x = neighbourhood_group)) +
  geom_bar(fill = "skyblue", color = "black") +
  ggtitle("Share of Neighborhood") +
  xlab("Neighbourhood Group") +
  ylab("Count") +
  theme_minimal()
# Assuming you have a dataframe called 'main_df' with the necessary columns


ggplot(data, aes(x = neighbourhood_group, y = price, fill = neighbourhood_group)) +
  geom_violin() +
  labs(title = 'Price distribution for each neighbourhood') +
  theme_minimal() +
  scale_fill_discrete(name = 'Neighbourhood Group')

# Sample data (replace this with your actual dataset)
set.seed(123)
sample_df <- data[sample(nrow(data), 10000), ]

# Mapbox access token
mapbox_access_token <- "pk.eyJ1IjoibWFvc2VmIiwiYSI6ImNrMTNzYXY5dDBjcHIzbW51d2J1ZjJweHoifQ.CA3fec_PEoQHxf9jr7yGaA"

# Creating a scattermapbox plot
plot_ly(
  data = sample_df,
  type = "scattermapbox",
  lon = ~longitude,
  lat = ~latitude,
  mode = "markers",
  marker = list(
    size = 5,
    color = ~price,
    colorscale = "Magma",
    reversescale = FALSE,
    colorbar = list(title = "Price ($)")
  )
) %>%
  # Setting layout parameters
  layout(
    title = "Airbnb prices in New York City",
    hovermode = "closest",
    mapbox = list(
      accesstoken = mapbox_access_token,
      bearing = 0,
      center = list(
        lat = 40.7,
        lon = -74
      ),
      pitch = 0,
      zoom = 9
    )
  )
#variable correlation

numeric_columns <- which(sapply(sample_df, is.numeric))

# Print the column numbers
print(numeric_columns)


# Compute the correlation matrix
cor_matrix <- cor(sample_df[, -c(1,2,3,4,5,6,9,13)])  # Exclude non-numeric columns like 'id', 'name', 'host_name'

# Create a correlation heatmap
corrplot(cor_matrix, method = "color", type = "upper", order = "hclust", tl.col = "black", tl.srt = 90,, main = "Correlation of Variables")

# List of columns to be dropped
columns_to_drop <- c("name", "id", "host_name", "last_review","room_type")

# Drop specified columns
sample_df <- sample_df[, !names(sample_df) %in% columns_to_drop]
# Assuming 'testdata' is your data frame
unique_neighbourhood_group <- unique(sample_df$neighbourhood_group)
# Print the modified dataset
print(unique_neighbourhood_group)
# Assuming 'sample_df' is your data frame
sample_df$origin <- factor(sample_df$origin, levels = c("1", "2", "3", "4", "5", "6"), labels = c("Bronx", "Brooklyn", "Manhattan", "Queens", "Staten", "Island"))

# Convert factor levels to numeric values
sample_df$origin_numeric <- as.numeric(sample_df$origin)

sample_df$origin <- factor(sample_df$origin, levels = c("1", "2", "3","4", "5", "6"), labels = c("Bronx", "Brooklyn", "Manhattan","Queens","Staten","Island")    
sample_df$neighbourhood_group <- as.factor(sample_df$neighbourhood_group)

# Convert factor levels to numeric values
sample_df$neighbourhood_group_numeric <- as.numeric(sample_df$neighbourhood_group)
print(sample_df)
#install.packages("caret")
library(caret)
# Assuming 'price' is your dependent variable and other columns are independent variables
# Replace 'airbnb_data' with the actual name of your data frame

# Create the design matrix with dummy variables
m <- lm(price ~ neighbourhood_group + latitude + longitude + minimum_nights + 
          number_of_reviews + reviews_per_month + availability_365,
        data = sample_df, x = TRUE)

# Extract the design matrix (without intercept)
X <- m$x
X <- X[, -c(1)]  # remove the intercept

# Create training and test data
frac <- 0.7  # training is 70% of the whole dataset
trainindices <- sample(seq(1, dim(X)[1]), round(dim(X)[1] * frac))
xx <- as.matrix(X[trainindices, ])
yy <- sample_df$price[trainindices]
xxt <- as.matrix(X[-trainindices, ])
yyt <- sample_df$price[-trainindices]

# Finally, force the dummy levels to be present in all models using force.in
m <- regsubsets(xx, yy, force.in = c(1, 2), int = TRUE, nbest = 1000, nvmax = dim(X)[2], method = c("ex"), really.big = TRUE)

# Verify that the dummy variables are active (=TRUE) in all models
cleaps <- summary(m, matrix = TRUE)
cleaps$which

# Set seed for reproducibility
set.seed(123)
trainindices <- createDataPartition(sample_df$target_variable, p = 0.7, list = FALSE)

train_data <- sample_df[trainindices, ]
test_data <- sample_df[-trainindices, ]
# Create indices for train and test sets
train_indices <- createDataPartition(sample_df$price, p = 0.8, list = FALSE)

# Split the dataset into train and test sets
#traindata <- sample_df[train_indices, ]
#testdata <- sample_df[-train_indices, ]

#install.packages("leaps")
#library(leaps)
#sapply(test_data, function(x) sum(is.na(x)))
#sapply(traindata, function(x) sum(is.na(x)))
# Replace missing values with the mode
# Convert categorical column to factor
test_data$neighbourhood_group <- as.factor(testdata$neighbourhood_group)

# Convert factor levels to numeric values
testdata$neighbourhood_group_numeric <- as.numeric(testdata$neighbourhood_group)

# MULTICOLLINEARLITY CHECK

m1 <- lm(price ~ neighbourhood_group +neighbourhood+ number_of_reviews  + availability_365 + minimum_nights +reviews_per_month ,data=train_data)
summary(m1)

m2 <- lm(price ~ neighbourhood_group + number_of_reviews  + minimum_nights + availability_365 ,data=train_data)
summary(m2)
#install.packages("forecast")
library(forecast)
# Ensure factor levels in the test dataset match those in the training dataset
test_data$neighbourhood_group <- factor(test_data$neighbourhood_group, levels = levels(train_data$neighbourhood_group))
test_data$neighbourhood <- factor(test_data$neighbourhood, levels = levels(train_data$neighbourhood))
print(test_data)
# Predict using the model
predicted_value <- predict(m1, test_data)

# Check summary or other relevant analyses
summary(predicted_value)


####Predicting the values using Best model ##################
predicted_value<-predict(m1,test_data)
summary(predicted_value)
View(predicted_value)

accuracy(predicted_value, testdata$price)


####Predicting the values using Best model BM2##################
predicted_value<-predict(m2,testdata)
summary(predicted_value)
View(predicted_value)

accuracy(predicted_value, testdata$price)
# Assuming your response variable is named "price"
#response_variable <- testdata$price

# Exclude the response variable and other non-numeric columns
#predictor_variables <- subset(testdata, select = -c(price, neighbourhood_group, neighbourhood  ))

# Convert any remaining factors to numeric (if needed)
#predictor_variables <- as.data.frame(lapply(predictor_variables, as.numeric))

# Generate all subset models using regsubsets
#subset_models <- regsubsets(response_variable ~ ., data = predictor_variables, nbest = 100, method = "ex", really.big = TRUE)

# Display the summary of the subset models
#summary(subset_models)
# Display the summary of the subset models
#summary(subset_models)


