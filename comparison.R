# Load necessary libraries
library(dplyr)

# Assuming your data is in a data frame called 'df' with columns:
# 'median_salary', 'average_salary', 'continent_name'

# Research Question 1: Correlation between Median and Average Salary within each continent

# Calculate the Pearson correlation for each continent
correlations <- df %>%
  group_by(continent_name) %>%
  summarize(correlation = cor.test(median_salary, average_salary, method = "pearson", use = "complete.obs")$estimate)

# Print the correlations
print(correlations)
