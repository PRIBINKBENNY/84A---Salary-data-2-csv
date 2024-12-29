# Load necessary library
library(ggplot2)

# Load the dataset
salary_data <- read.csv("Datasets/salary_data.csv")
print("Dataset loaded:")
print(head(salary_data))

# Check column names
print("Column names:")
print(names(salary_data))

# Check unique continent values
print("Unique continent names:")
print(unique(salary_data$continent_name))

# Filter data for Europe and Asia
filtered_data <- subset(salary_data, continent_name %in% c("Europe", "Asia"))
print("Filtered data:")
print(head(filtered_data))
print("Number of rows in filtered data:")
print(nrow(filtered_data))

# Create the Box Plot
if (nrow(filtered_data) > 0) {
  box_plot <- ggplot(filtered_data, aes(x = continent_name, y = average_salary, fill = continent_name)) +
    geom_boxplot(notch = TRUE, width = 0.6, alpha = 0.8, color = "black") +
    labs(title = "Notched Box Plot: Average Salaries in Europe vs Asia",
         subtitle = "Confidence intervals indicated with notches",
         x = "Continent",
         y = "Average Salary (USD)") +
    scale_fill_manual(values = c("Europe" = "#A3D2CA", "Asia" = "#F4A261")) +
    theme_minimal()
  print("Displaying Box Plot...")
  print(box_plot)
} else {
  print("Filtered data is empty. Check your dataset and filtering criteria.")
}
