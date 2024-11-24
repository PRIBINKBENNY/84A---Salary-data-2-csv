# Create a box plot of average_salary by continent_name
boxplot(average_salary ~ continent_name, data = df,
        xlab = "Continent", ylab = "Average Salary",
        main = "Average Salary by Continent")
