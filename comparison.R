# Load necessary libraries
library(ggplot2)
library(dplyr)
library(caret)
library(randomForest)
library(tidyr)

# Load the dataset
data <- read.csv("salary_data.csv")

# Summary statistics
summary(data)

# Check for missing values
colSums(is.na(data))

# Scatter plot (Median vs Average Salary)
ggplot(data, aes(x = median_salary, y = average_salary)) +
  geom_point(color = "blue") +
  labs(title = "Median vs Average Salary", x = "Median Salary", y = "Average Salary") +
  theme_minimal()

# Boxplot (Salary by Continent)
ggplot(data, aes(x = continent_name, y = median_salary)) +
  geom_boxplot(fill = "cyan") +
  labs(title = "Salary Distribution by Continent", x = "Continent", y = "Median Salary") +
  theme_minimal()

# Statistical Test
cor.test(data$median_salary, data$average_salary)

# Save the enhanced dataset
write.csv(data, "enhanced_dataset.csv", row.names = FALSE)

