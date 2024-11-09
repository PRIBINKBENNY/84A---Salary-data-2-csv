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
