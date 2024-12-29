# Load the ggplot2 library
library(ggplot2)

# Read the data
salary_data <- read.csv("Datasets/salary_data.csv")

# Create the violin plot
ggplot(salary_data[salary_data$continent_name %in% c("Europe", "Asia"), ], 
       aes(x = continent_name, y = average_salary)) +
  geom_violin(trim = FALSE, alpha = 0.7) +  # Adjust transparency
  labs(title = "Distribution of Average Salaries: Europe vs. Asia",
       x = "Continent",
       y = "Average Salary") +
  theme_bw()
