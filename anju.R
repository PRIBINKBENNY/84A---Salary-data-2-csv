# Load necessary libraries
library(ggplot2)

# Read the CSV file
file_path <- "Datasets/salary_data.csv"
salary_data <- read.csv(file_path)

# View the structure of the dataset
str(salary_data)

# Basic Scatter Plot - Example: Years of Experience vs. Salary
ggplot(salary_data, aes(x = Years.of.Experience, y = Salary)) +
  geom_point(color = "blue", size = 3) +
  labs(title = "Scatter Plot of Years of Experience vs Salary",
       x = "Years of Experience",
       y = "Salary") +
  theme_minimal()

# Box Plot - Salary distribution
ggplot(salary_data, aes(y = Salary)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(title = "Box Plot of Salary Distribution",
       y = "Salary") +
  theme_minimal()

# Histogram - Salary Distribution
ggplot(salary_data, aes(x = Salary)) +
  geom_histogram(binwidth = 5000, fill = "lightgreen", color = "black") +
  labs(title = "Histogram of Salary Distribution",
       x = "Salary",
       y = "Frequency") +
  theme_minimal()

# Line Plot - Example: Time Series Data (if a time column exists)
# Assuming 'Year' column exists in your dataset
# ggplot(salary_data, aes(x = Year, y = Salary)) +
#   geom_line(color = "red", size = 1) +
#   labs(title = "Salary Over Time",
#        x = "Year",
#        y = "Salary") +
#   theme_minimal()
