# Load the ggplot2 library for visualization
library(ggplot2)

# Read the data from the CSV file
salary_data <- read.csv("Datasets/salary_data.csv")

# Create a box plot comparing average salaries between Europe and Asia
ggplot(salary_data[salary_data$continent_name %in% c("Europe", "Asia"), ], 
       aes(x = continent_name, y = average_salary)) +
  geom_boxplot() +
  labs(title = "Comparison of Average Salaries: Europe vs. Asia",
       x = "Continent",
       y = "Average Salary") +
  theme_bw()  # Apply a black and white theme for clarity