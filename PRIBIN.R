# Load necessary library
library(readr)

# Read the CSV file
#salary_data <- read_csv("/Users/pribinkbenny/College_Works/salary_data.csv")
salary_data <- read_csv("salary_data.csv")

exists("salary_data")  # Returns TRUE if the object exists

# View the first few rows of the data
head(salary_data)
str(salary_data)
summary(salary_data)
library(ggplot2)

ggplot(salary_data, aes(x = highest_salary, y = median_salary)) +
  geom_point(color = "blue", alpha = 0.7) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Scatterplot of Median Salary vs. Highest Salary",
       x = "Highest Salary",
       y = "Median Salary") +
  theme_minimal()

# Load necessary library
library(ggplot2)

# Create a histogram with density curve
ggplot(salary_data, aes(x = median_salary)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "blue", alpha = 0.7) +
  geom_density(color = "red", size = 1) +
  labs(title = "Histogram of Median Salary with Density Curve",
       x = "Median Salary",
       y = "Density") +
  theme_minimal()

# Save the plot as a PNG file
ggsave("median_salary_histogram.png")

