# Load necessary libraries
library(ggplot2)

# Visualization 1: Scatter plot of Median vs Average Salary by Continent
ggplot(df, aes(x = median_salary, y = average_salary, color = continent_name)) +
  geom_point() +
  labs(title = "Scatter Plot of Median vs Average Salary by Continent",
       x = "Median Salary", y = "Average Salary", color = "Continent") +
  theme_minimal()

# Visualization 2: Box plot of Median Salary by Continent
ggplot(df, aes(x = continent_name, y = median_salary)) +
  geom_boxplot() +
  labs(title = "Box Plot of Median Salary by Continent",
       x = "Continent", y = "Median Salary") +
  theme_minimal()