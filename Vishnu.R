# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load the data (replace with the correct path if necessary)
data <- read.csv("salary_data.csv")

# Research Question 1: Correlation between median_salary and average_salary within each continent
ggplot(data, aes(x = average_salary, y = median_salary, color = continent_name)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Correlation Between Median and Average Salary",
       x = "Average Salary", y = "Median Salary") +
  theme_minimal()

# Research Question 2: Wage span effect on median_salary
data <- data %>% mutate(wage_span = highest_salary - lowest_salary)

ggplot(data, aes(x = continent_name, y = median_salary, fill = continent_name)) +
  geom_boxplot() +
  labs(title = "Effect of Wage Span on Median Salary",
       x = "Continent", y = "Median Salary") +
  theme_minimal()

# Research Question 3: Differences in Salaries Across Continents
# Histogram for highest_salary
ggplot(data, aes(x = highest_salary, fill = continent_name)) +
  geom_histogram(binwidth = 1000, alpha = 0.7, position = "dodge") +
  labs(title = "Distribution of Highest Salaries Across Continents",
       x = "Highest Salary", y = "Count") +
  theme_minimal()

# Box plot for highest_salary and median_salary comparison
ggplot(data, aes(x = continent_name, y = highest_salary, fill = continent_name)) +
  geom_boxplot() +
  labs(title = "Comparison of Highest Salary Across Continents",
       x = "Continent", y = "Highest Salary") +
  theme_minimal()

ggplot(data, aes(x = continent_name, y = median_salary, fill = continent_name)) +
  geom_boxplot() +
  labs(title = "Comparison of Median Salary Across Continents",
       x = "Continent", y = "Median Salary") +
  theme_minimal()
