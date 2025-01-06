# Load necessary libraries
library(ggplot2) # Added for visualizations

# Assuming your data is in a data frame called 'df' with columns:
# 'median_salary', 'average_salary', 'continent_name', 'highest_salary', 'lowest_salary'

# Research Question 1: Correlation between Median and Average Salary within each continent
# Calculate the correlation for each continent
correlations <- df %>%
  group_by(continent_name) %>%  # Group by continent
  summarize(correlation = cor.test(median_salary, average_salary)$estimate)  # Calculate correlation

# Print the correlations
print(correlations)  # Display the results

# Visualization 1: Scatter plot of Median vs Average Salary
# Create a scatter plot
ggplot(df, aes(x = median_salary, y = average_salary, color = continent_name)) +
  geom_point() +  # Add points to the plot
  labs(title = "Scatter Plot of Median vs Average Salary by Continent",  # Set the title
       x = "Median Salary", y = "Average Salary", color = "Continent") +  # Label the axes
  theme_minimal()  # Apply a clean theme

# Visualization 2: Box plot of Median Salary by Continent
# Create a box plot
ggplot(df, aes(x = continent_name, y = median_salary)) +
  geom_boxplot() +  # Add box plots
  labs(title = "Box Plot of Median Salary by Continent",  # Set the title
       x = "Continent", y = "Median Salary") +  # Label the axes
  theme_minimal()  # Apply a clean theme