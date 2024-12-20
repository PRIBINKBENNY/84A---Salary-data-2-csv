# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load your dataset
salary_data <- read.csv("Datasets/salary_data.csv")

# Data Cleaning and Preparation

# Select relevant columns and remove rows with missing values
data_clean <- salary_data %>%
  select(continent_name, median_salary) %>%
  na.omit()

# Visualizations

# Create boxplots to visualize the gender pay gap across continents
# (using median_salary)
ggplot(data_clean, aes(x = continent_name, y = median_salary, fill = continent_name)) +
  geom_boxplot() +
  labs(title = "Gender Pay Gap Across Continents (Median Salary)",
       x = "Continent",
       y = "Median Salary") +
  theme_minimal()

# Statistical Analysis

# Since you're comparing median salaries between continents,
# consider using the Kruskal-Wallis test (non-parametric)
# as an alternative to ANOVA.

# Example: Kruskal-Wallis test for comparing median_salary between continents
kruskal.test(median_salary ~ continent_name, data = data_clean)

# If the Kruskal-Wallis test shows significant differences,
# perform post-hoc tests (e.g., Dunn's test) to determine which continents
# differ significantly from each other.

# Export Visualizations
ggsave("gender_pay_gap_across_continents.png", width = 8, height = 6)