# Load necessary libraries
library(dplyr)
library(ggplot2)
library(stats)
library(magrittr)

# Load the dataset (replace with your file path if needed)
data <- read.csv("Datasets/salary_data.csv")

# 1. Is there a correlation between the median salary and the average salary within each continent?

# Calculate correlation by continent
correlations <- data %>%
  group_by(continent_name) %>%
  summarize(correlation = cor(median_salary, average_salary, use = "complete.obs"))

print(correlations)

# Scatter plot with linear regression line to visualize correlation
ggplot(data, aes(x = average_salary, y = median_salary, color = continent_name)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Correlation Between Median and Average Salary by Continent",
       x = "Average Salary", y = "Median Salary") +
  theme_minimal()

# 2. Does the wage span (difference between highest and lowest salaries) affect the median salary within each continent?

# Create a new column for wage span
data <- data %>%
  mutate(wage_span = highest_salary - lowest_salary)

# Calculate correlation between wage span and median salary by continent
wage_span_correlation <- data %>%
  group_by(continent_name) %>%
  summarize(correlation = cor(wage_span, median_salary, use = "complete.obs"))

print(wage_span_correlation)

# Scatter plot to visualize wage span vs median salary
ggplot(data, aes(x = wage_span, y = median_salary, color = continent_name)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Effect of Wage Span on Median Salary by Continent",
       x = "Wage Span (Highest - Lowest Salary)", y = "Median Salary") +
  theme_minimal()

# 3. Is there a significant difference in the highest salary between continents?

# Perform ANOVA to test the difference in highest salaries across continents
anova_result <- aov(highest_salary ~ continent_name, data = data)
summary(anova_result)

# Post-hoc Tukey test for pairwise comparison of means
tukey_result <- TukeyHSD(anova_result)
print(tukey_result)

# Boxplot for highest salary by continent
ggplot(data, aes(x = continent_name, y = highest_salary, fill = continent_name)) +
  geom_boxplot() +
  labs(title = "Comparison of Highest Salary Across Continents",
       x = "Continent", y = "Highest Salary") +
  theme_minimal()

# Comparison for Proportions (Example: Proportion of countries with high median salary across continents)

# Define a threshold for "high median salary" (e.g., above 5000)
threshold <- 5000
data <- data %>%
  mutate(high_median_salary = ifelse(median_salary > threshold, 1, 0))

# Calculate proportions of high median salary by continent
proportions <- data %>%
  group_by(continent_name) %>%
  summarize(proportion_high = mean(high_median_salary))

print(proportions)

# Bar plot for proportions
ggplot(proportions, aes(x = continent_name, y = proportion_high, fill = continent_name)) +
  geom_bar(stat = "identity") +
  labs(title = "Proportion of Countries with High Median Salary by Continent",
       x = "Continent", y = "Proportion of High Median Salary") +
  theme_minimal()

