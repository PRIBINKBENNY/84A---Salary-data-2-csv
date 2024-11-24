# Load necessary libraries
library(ggplot2)
library(dplyr)
library(caret)
library(randomForest)
library(tidyr)

# Load the dataset
file_path <- "/Users/pribinkbenny/College\ Works/Datasets/salary_data.csv"
data <- read.csv(file_path)

# Check the structure of the dataset
str(data)

# Summary statistics
summary(data)

# Check for missing values
colSums(is.na(data))

# Exploratory Data Analysis
# Histogram of numeric columns
numeric_columns <- c("median_salary", "average_salary", "lowest_salary", "highest_salary")

for (col in numeric_columns) {
  plot <- ggplot(data, aes_string(col)) +
    geom_histogram(bins = 30, fill = "blue", alpha = 0.7) +
    ggtitle(paste("Histogram of", col)) +
    theme_minimal()
  
  print(plot)  # Ensure the plot is printed within the loop
}


# Boxplots grouped by continent
for (col in numeric_columns) {
  plot <- ggplot(data, aes_string(x = "continent_name", y = col)) +
    geom_boxplot(fill = "cyan", alpha = 0.7) +
    ggtitle(paste("Boxplot of", col, "by Continent")) +
    xlab("Continent") +
    ylab(col) +
    theme_minimal()
  
  print(plot)  # Ensure the plot is printed within the loop
}


# Pairplot using GGally
if (!requireNamespace("GGally", quietly = TRUE)) install.packages("GGally")
library(GGally)
ggpairs(data[, numeric_columns], title = "Pairplot of Salary Metrics")

# Group Analysis by Continent
continent_summary <- data %>%
  group_by(continent_name) %>%
  summarise(across(all_of(numeric_columns), mean, na.rm = TRUE))
print(continent_summary)

# Bar plot for grouped data
# Load tidyr for pivot_longer
if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")
library(tidyr)

# Convert continent_summary to long format
continent_summary_long <- continent_summary %>%
  pivot_longer(cols = -continent_name, names_to = "Metric", values_to = "Value")

# Create bar plot
ggplot(continent_summary_long, aes(x = continent_name, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle("Average Salary Metrics by Continent") +
  xlab("Continent") +
  ylab("Average Salary") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for readability


# Clustering using K-means
kmeans_data <- na.omit(data[, numeric_columns])
k <- 3  # Number of clusters
kmeans_result <- kmeans(kmeans_data, centers = k)
data$Cluster <- factor(kmeans_result$cluster)

# Scatter plot with clusters
ggplot(data, aes(x = median_salary, y = average_salary, color = Cluster)) +
  geom_point(size = 3) +
  ggtitle("K-Means Clustering (Median vs Average Salary)") +
  theme_minimal()

# Regression Analysis
target <- "average_salary"
predictors <- numeric_columns[numeric_columns != target]

# Prepare data for training and testing
set.seed(42)
train_index <- createDataPartition(data[[target]], p = 0.7, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Random Forest Model
rf_model <- randomForest(as.formula(paste(target, "~ .")), data = train_data[, c(predictors, target)])
print(rf_model)

# Feature Importance
importance <- importance(rf_model)
varImpPlot(rf_model)

# Predict and Evaluate
test_data$predictions <- predict(rf_model, test_data)
mse <- mean((test_data$average_salary - test_data$predictions)^2)
cat("Mean Squared Error:", mse, "\n")

# Actual vs Predicted Plot
ggplot(test_data, aes(x = average_salary, y = predictions)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  ggtitle("Actual vs Predicted Average Salary") +
  theme_minimal()

# Save Enhanced Dataset
write.csv(data, "enhanced_dataset_with_clusters.csv", row.names = FALSE)
