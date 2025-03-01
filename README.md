# SQL Data Transformation Project

## Project Overview

This project demonstrates SQL-based data analysis on employee data. It imports employee records from a CSV file, performs various data transformations and analyses using MySQL, and exports the resulting analytical tables as CSV files.

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/DZEgGAYZ2Es/0.jpg)](https://www.youtube.com/watch?v=DZEgGAYZ2Es)

## Getting Started

### Prerequisites

- MySQL installed on your system
- Employee data CSV file (`employee_data_clean.csv`)

### Running The Transformation

```bash
mysql -u root -p --local-infile=1 < transform_data.sql
```

## Database Creation

The project creates a database called `employee_analytics` with the following employee data structure:

* EmployeeID (Primary Key)
* Name
* Age
* Department
* DateOfJoining
* YearsOfExperience
* Country
* Salary
* PerformanceRating

## Data Transformations

The project performs the following analyses:

1. **Department Salary Analysis**: Average salary by department
2. **Tenure to Salary Analysis**: Relationship between years of experience and salary
3. **Performance Rating Analysis**: Average salary by performance rating
4. **Start Year Analyses**:
   * Performance scores by employee start year
   * Employee count by start year
   * Salary statistics by start year
5. **Combined Analysis**: Comprehensive metrics by start year including employee count, salary statistics, and average performance scores

## Exporting Results

The transformed tables were exported to CSV files using the command line:

```bash
for table in table_by_start_year salary_to_department_analysis salary_to_tenure_analysis performance_by_salary_analysis performance_by_start_year salary_by_start_year employees_by_start_year; do
    mysql -u root -p -e "SELECT * FROM employee_analytics.$table;" --batch | sed 's/\t/,/g' > outputs/$table.csv
done
```

## Output Files

The project generated the following CSV files:

* `salary_to_department_analysis.csv`: Average salary by department
* `salary_to_tenure_analysis.csv`: Salary trends by years of experience
* `performance_by_salary_analysis.csv`: Average salary by performance rating
* `performance_by_start_year.csv`: Performance trends by start year
* `employees_by_start_year.csv`: Employee count by start year
* `salary_by_start_year.csv`: Salary statistics by start year
* `table_by_start_year.csv`: Combined metrics by employee start year

These outputs can be used for further analysis.
