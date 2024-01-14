setwd("~/Linear statistics model analysis")
# Reading the data file 
data<-read.table("countydemographics.txt")
data <-as.data.frame(data)
colnames(data, do.NULL = FALSE)
colnames(data)<-c("id","county","state","area","popul","pop1834","pop65plus","phys","beds",
                  "crimes","higrads","bachelors","poors","unemployed","percapitaincome","totalincome","region")

# Laoding the packages
install.packages("corrplot")
library(corrplot)
install.packages("ggcorrplot")
library(ggcorrplot)
install.packages("MASS")
library(MASS)
install.packages("lmtest")
library(lmtest)


# created a data frame without the selected  variables
column_not_int <- c('phys', 'beds', 'area','state','county')

county_data <- data[, !(names(data) %in% column_not_int)]
View(county_data)
# summary of data
summary(county_data)
str(county_data)

# Histogram of covariates 
hist(county_data$poors, col = "green", main = "Histogram ofpoors", xlab = "Poors")
hist(county_data$unemployed, col = "yellow", main = "Histogram of region", xlab = "Region")
hist(county_data$crimes, main="Distribution of Crimes", xlab="Crimes", ylab="Frequency", col="skyblue", border="black")
hist(county_data$pop1834, main="Distribution of Crimes", xlab="pop1834", ylab="Frequency", col="skyblue", border="black")
hist(county_data$bachelors, main="Distribution of Crimes", xlab="bachelors", ylab="Frequency", col="skyblue", border="black")

# Normality check on crime data
qqnorm(county_data$crimes)
qqline(county_data$crimes, col = 2)



# corelation matrix on county_data
cor_matrix <- cor(county_data) 
cor_matrix


ggcorrplot(cor_matrix, hc.order = TRUE, type = "lower",  lab = TRUE)

# region  wise distribution on data 
barplot(table(county_data$region), col="skyblue", main="Distribution of Regions", xlab="Region", ylab="Frequency")

# box plot of crimes on regions
boxplot(crimes ~ region, data = county_data, col = "green",main = "Boxplot in region level  ", xlab = "Region", ylab = "crimes")


#selected_variables
selected_variables <- c("poors", "unemployed", "bachelors", "totalincome", "pop1834")

max_regions <- sapply(selected_variables, function(variable) find_max_region(county_data, variable))
max_regions

# log tarnsformations
county_data$totalincome<-log(county_data$totalincome)
county_data$pop1834<-log(county_data$pop1834)
county_data$unemployed<-log(county_data$unemployed)
county_data$poors<-log(county_data$poors)
county_data$bachelors<-log(county_data$bachelors)

# par plot on the selected covariates
par(mfrow=c(2,3))
plot(county_data$pop1834,county_data$crimes,main="crime_rate-pop1834")
plot(county_data$unemployed,county_data$crimes,main="crime_rate-unemployed")
plot(county_data$totalincome,county_data$crimes,main="crime_rate-totalincome")
plot(county_data$poors,county_data$crimes,main="crime_rate-poors")
plot(county_data$bachelors,county_data$crimes,main="crime_rate-bachelors")




county_data$region <- as.factor(county_data$region)
is.factor(county_data$region)
county_data$region <- factor(county_data$region, levels = c(4, 1, 2, 3))

# model Building
#full_model
nb_model <- glm.nb(crimes ~ region + poors + totalincome +pop1834 + bachelors + unemployed, 
                   data = county_data)
summary(nb_model)

#model1- simple model
model1 <- glm.nb(crimes  ~ region + poors  + totalincome + unemployed  , data = county_data)
summary(model1)

#model2- simple model
model2 <- glm.nb(crimes ~ region + poors  + pop1834 + bachelors , data = county_data)
summary(model2)



# Test statistics
wald_test1 <- waldtest(nb_model, model1)
wald_test1

wald_test2 <- waldtest(nb_model, model2)
wald_test2


# analysis of deviance
anova_test1 <- anova(nb_model, model1, test = "Chisq")
anova_test1
anova_test2 <-anova(nb_model, model2, test = "Chisq")
anova_test2

