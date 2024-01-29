
**LINEAR STATISTICAL  MODELS**

In our day-to-day lives, the growing data is playing a major role in shaping and
understanding the world to forecast the future outcomes. The rapid increase of
data across all fields has led to the pathway of data analysis. The importance
of each data has led to uncover meaningful insights, patterns for the decisionmaking process.
The fundamental approach in extracting information from the
data in statistical modeling is analysis from linear regression models . The
linear regression helps in understanding the relationship or association between
variables in the field of data analysis.In this analysis we figure out the different
factors that influence the dependent variable using linear models .Here,I have tried to create models for different scenarios with help of R.

**Airbnb Price prediction**

**Introduction: Airbnb's Impact on NYC's Hospitality Landscape**

The Airbnb platform has revolutionized the way people discover accommodations, shaking up the traditional hospitality industry with millions of listings worldwide. This transformation is particularly evident in the dynamic city of New York City (NYC), renowned for its diverse neighborhoods and fluctuating demand for temporary lodgings. In response to the competitive nature of the NYC accommodation market, hosts grapple with the challenge of determining optimal prices. Factors such as location, property features, and local events contribute to the complexity of this pricing dilemma. To address this challenge, the development of a robust price prediction model becomes crucial for hosts, providing not only a strategic advantage but also simplifying the pricing process in this bustling metropolis.

****Objective: Precise Linear Regression Model for NYC Airbnb Prices****

The primary objective of this analysis is to construct a precise linear regression model for forecasting Airbnb accommodation prices in New York City. Leveraging data from nearly 49,000 listings in 2019, the focus is specifically on predicting prices for private room-type accommodations. The overarching goals encompass the establishment of dependable models for price prediction and the identification of significant factors influencing accommodation prices in the diverse NYC market. An integral revelation of this analysis is the substantial impact of geographical location on pricing dynamics.

**Data Preprocessing and Exploratory Analysis****

Data Handling and Exploration:
In the initial stages of analysis, missing values within the dataset were addressed through imputation, primarily using the mean for continuous variables. The subsequent Exploratory Data Analysis (EDA) involved a visual exploration of the dataset, utilizing charts and graphs to discern price trends across different neighborhood groups.

Outlier Identification and Treatment:
The Interquartile Range (IQR) method was employed to detect outliers in the 'price' variable, systematically removing them to enhance the accuracy of subsequent models.

Normalization and Scaling:
Numerical variables underwent normalization and scaling, employing min-max scaling to ensure fair contributions from each variable and prevent the dominance of specific features.

****Data Partitioning and Model Building****

Data Splitting:
The dataset underwent partitioning into training and testing sets, adhering to an 80-20 ratio. This facilitated model training and evaluation on new, unseen data, ensuring a fair assessment of predictive effectiveness.

Model Building and Selection:
Four distinct linear regression models (m1 to m4) were constructed and evaluated, each considering various predictors to gauge their impact on Airbnb prices. The models underwent backward and stepwise feature selection to optimize relevance.

**Model Results and Insights****

Performance Overview:
The analysis provides insights into each model's performance, focusing on R-squared values and adjusted R-squared values. Model 2, incorporating predictors like location, host-related details, and neighborhood, emerged as the most effective in explaining price variations.

****Key Findings from Models:****
Each model uncovered specific insights into the factors influencing prices, ranging from the impact of additional nights and host listings to the significant influence of geographical coordinates.

****Conclusion: Guiding Hosts in NYC's Airbnb Market****

In conclusion, this analysis equips hosts in New York City with essential knowledge for determining Airbnb accommodation prices. The revelation of influential factors and the identification of an optimal model contribute valuable insights to hosts navigating the complexities of the NYC hospitality landscape.


**US INSURANCE DATA**

****Introduction****

Understanding the intricacies of health insurance costs is crucial yet complex. This analysis delves into a comprehensive dataset on health insurance in the US, aiming to identify factors influencing costs, such as age, BMI, and smoking habits. Predictive models (m1 and m2) are constructed to accurately forecast insurance charges. The dataset exhibits diverse ages, a normal BMI distribution, and balanced gender representation. Visualizations aid in identifying patterns, while relationships analysis reveals the significant impact of age, BMI, and smoking habits on costs.
**** Data Preprocessing and Analysis****

The dataset, encompassing health insurance information for 1200 individuals, is thoroughly explored. No missing values are identified, and key insights into variable distribution and relationships are gained. Summary statistics unveil a diverse age range, a normal BMI distribution, and balanced gender representation. Visualizations enhance understanding, showcasing concentrated age groups, BMI trends, and skewed premium distributions. Bivariate analysis highlights the impact of smoking on charges.

****Data Preparation****

The preparation phase involves defining predictor and target matrices, categorizing data, and standardizing numerical variables. Training and testing sets are created, and new features, including age squared and binary indicators, are introduced to enhance model performance.

****Model Building and Selection****

Two linear regression models (m1 and m2) are developed using the training dataset. After outlier removal, both models (m1 after and m2 after) show improved performance metrics. Model comparison based on AIC, BIC, and ANOVA results favors m2 after, considering its balance between complexity and accuracy.

**** Results****

Model m2 after is selected as the optimal choice due to its superior adjusted R-squared and lower AIC and BIC values. Despite the inclusion of nonlinear and interaction terms, m2 after balances complexity and predictive accuracy. The Root Mean Squared Error (RMSE) values show minor variation, with m2 after remaining the most efficient model. The conclusion emphasizes m2 after as a reliable tool for predicting health insurance charges, offering valuable insights for industry professionals and policymakers. The model's simplicity, robustness, and explanatory power position it as a practical solution in navigating the complexities of the health insurance landscape.


**Generalized Linear Model for County Data**
**Introduction**

This study focuses on reported crimes in various counties across the United States during 1990-92, with the primary goal of understanding factors related to crime occurrence. The response variable of interest is 'Crimes' across different counties. Generalized Linear Models (GLMs), specifically using the Negative Binomial distribution, are chosen over traditional linear models due to the non-normal distribution of the data. GLMs, known for their flexibility, are well-suited for modeling count data with variations in distributions.

** Exploratory Data Analysis:**

The County data includes covariates like county, population demographics, crimes, educational levels, per capita income, and regional information. Histograms, QQ plots, and boxplots are employed to gain insights into the distribution of crimes. The data exhibits a skewed distribution, especially with many small values and a few large values. Covariate analysis reveals positive correlations between poors, bachelors, total income, population demographics, and crime counts. The distribution of crimes across regions is explored, showing variations in dispersion.

** Model Building**

GLMs with Negative Binomial Distribution are employed to model the count data. Covariates such as regions, poors, total income, and population demographics are considered. Model outputs indicate insights into covariate coefficients, residuals, and null deviance. Negative coefficients for regions suggest lower crime rates compared to the baseline region, while positive coefficients for poors, pop1834, total income indicate increased crime rates. Model selection involves comparing complex and simpler models based on AIC values and residual deviance.

** Results**

The full model, despite its complexity, outperforms simpler models in capturing variability. The Wald test and ANOVA results strongly support the rejection of null hypotheses, indicating that the models do not fit the data equally. The full model's flexibility is evidenced by its lower AIC and residual deviance values.

 **Conclusion**

The choice of GLM Negative Binomial model for the county data proves to be effective in explaining the relationship and factors influencing crime rate growth, especially in the presence of dispersed data. The full model, with the inclusion of covariates, demonstrates a significant relationship with crime rates. Test statistics further support the model's statistical significance and robustness in capturing the relationship with the response variable. This study contributes valuable insights for understanding and predicting crime rates in different counties.










