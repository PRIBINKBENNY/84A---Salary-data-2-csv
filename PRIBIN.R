# Load necessary libraries
library(ggplot2)
library(dplyr)
library(caret)
library(randomForest)

# Load your data
file_path <- "salary_data 2.csv"  # Update with the actual file path in your R environment
data <- read.csv(file_path)

# Preview the data
print(head(data))

# Data summary
summary(data)

# Check for missing values
print(colSums(is.na(data)))

# Basic Plots
# Histogram for each numeric variable
num_vars <- sapply(data, is.numeric)
for (var in names(data)[num_vars]) {
  ggplot(data, aes_string(var)) +
    geom_histogram(bins = 30, fill = "blue", alpha = 0.7) +
    ggtitle(paste("Histogram of", var)) +
    theme_minimal() +
    print()
}

# Scatter plots for correlations between numeric variables
pairs(data[, num_vars], main = "Scatterplot Matrix")

# Boxplot for categorical vs numeric variables
cat_vars <- sapply(data, is.factor)
for (cat in names(data)[cat_vars]) {
  for (num in names(data)[num_vars]) {
    ggplot(data, aes_string(x = cat, y = num)) +
      geom_boxplot(fill = "cyan", alpha = 0.7) +
      ggtitle(paste("Boxplot of", num, "by", cat)) +
      theme_minimal() +
      print()
  }
}

# Algorithmic Analysis
# Prepare data for analysis
data_clean <- na.omit(data)  # Removing rows with missing values
target <- "YourTargetColumn"  # Replace with your target column
predictors <- setdiff(names(data_clean), target)

# Splitting data into train and test
set.seed(123)
train_index <- createDataPartition(data_clean[[target]], p = 0.7, list = FALSE)
train_data <- data_clean[train_index, ]
test_data <- data_clean[-train_index, ]

# Random Forest Model
rf_model <- randomForest(as.formula(paste(target, "~ .")), data = train_data)
print(rf_model)

# Predict and evaluate
predictions <- predict(rf_model, test_data)
confusionMatrix(predictions, test_data[[target]])

# Feature Importance
importance <- varImp(rf_model)
print(importance)

# Plot Feature Importance
varImpPlot(rf_model)

# Linear Regression (if target is numeric)
if (is.numeric(data_clean[[target]])) {
  lm_model <- lm(as.formula(paste(target, "~ .")), data = train_data)
  print(summary(lm_model))
  
  # Plot actual vs predicted
  test_data$predictions <- predict(lm_model, test_data)
  ggplot(test_data, aes_string(x = target, y = "predictions")) +
    geom_point(color = "blue") +
    geom_smooth(method = "lm", color = "red") +
    ggtitle("Actual vs Predicted") +
    theme_minimal()
}

# Clustering (if no target column is specified)
if (target == "YourTargetColumn") {
  k <- 3  # Number of clusters
  kmeans_result <- kmeans(data_clean[, num_vars], centers = k)
  data_clean$cluster <- as.factor(kmeans_result$cluster)
  
  ggplot(data_clean, aes(x = data_clean[, 1], y = data_clean[, 2], color = cluster)) +
    geom_point(size = 3) +
    ggtitle("K-Means Clustering") +
    theme_minimal()
}

