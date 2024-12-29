# Load necessary library
library(ggplot2)

# Read the dataset from the Datasets folder
salary_data <- read.csv("Datasets/salary_data.csv")

# Check if the dataset is loaded correctly
print("Preview of the dataset:")
print(head(salary_data))

# Subset data for Europe and Asia
filtered_data <- subset(salary_data, continent_name %in% c("Europe", "Asia"))

# Verify the filtered data
print("Filtered data for Europe and Asia:")
print(head(filtered_data))

# Create the Box Plot with Notches
box_plot <- ggplot(filtered_data, aes(x = continent_name, y = average_salary, fill = continent_name)) +
  geom_boxplot(notch = TRUE, width = 0.6, alpha = 0.8, color = "black") +
  labs(title = "Notched Box Plot: Average Salaries in Europe vs Asia",
       subtitle = "Confidence intervals indicated with notches",
       x = "Continent",
       y = "Average Salary (USD)") +
  scale_fill_manual(values = c("Europe" = "#A3D2CA", "Asia" = "#F4A261")) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none")

# Display the Box Plot
print("Displaying Box Plot...")
print(box_plot)

