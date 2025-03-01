-- 1. Setup Database
CREATE DATABASE IF NOT EXISTS employee_analytics;
USE employee_analytics;

-- Create the employee_data table
DROP TABLE IF EXISTS employee_data;
CREATE TABLE IF NOT EXISTS employee_data (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(60),
    Age INT,
    Department VARCHAR(20),
    DateOfJoining DATE,
    YearsOfExperience INT,
    Country VARCHAR(20),
    Salary INT,
    PerformanceRating VARCHAR(20)
);

-- 2. Import Data

LOAD DATA LOCAL INFILE 'employee_data_clean.csv' 
INTO TABLE employee_data
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(EmployeeID, Name, Age, Department, DateOfJoining, YearsOfExperience, Country, Salary, PerformanceRating);

SELECT * FROM employee_data;

-- 3. Basic Transformations

-- Average Salary by Department Analysis
DROP TABLE IF EXISTS salary_to_department_analysis;
CREATE TABLE salary_to_department_analysis AS
SELECT 
    Department,
    AVG(Salary) AS AverageSalary
FROM 
    employee_data
GROUP BY 
    Department
ORDER BY 
    AverageSalary DESC;


SELECT * FROM salary_to_department_analysis;

-- Tenure to Salary Analysis
DROP TABLE IF EXISTS salary_to_tenure_analysis;
CREATE TABLE salary_to_tenure_analysis AS
SELECT 
    YearsOfExperience AS TenureYears,
    AVG(Salary) AS AverageSalary
FROM 
    employee_data
GROUP BY 
    YearsOfExperience
ORDER BY 
    YearsOfExperience ASC;

SELECT * FROM salary_to_tenure_analysis;

-- Performance Rating Analysis
DROP TABLE IF EXISTS performance_by_salary_analysis;
CREATE TABLE performance_by_salary_analysis AS
SELECT 
    PerformanceRating,
    AVG(Salary) AS AverageSalary
FROM 
    employee_data
GROUP BY 
    PerformanceRating
ORDER BY 
    AverageSalary DESC;

SELECT * FROM performance_by_salary_analysis;

-- 4. Additional Transformations

-- Performance by Start Year Analysis
DROP TABLE IF EXISTS performance_by_start_year;
CREATE TABLE performance_by_start_year AS
SELECT 
    YEAR(DateOfJoining) AS StartYear,
    AVG(CASE 
        WHEN PerformanceRating = 'High Performers' THEN 5
        WHEN PerformanceRating = 'Average Performers' THEN 3
        WHEN PerformanceRating = 'Low Performers' THEN 1
        ELSE NULL
    END) AS AveragePerformanceScore
FROM 
    employee_data
GROUP BY 
    YEAR(DateOfJoining)
ORDER BY 
    StartYear;


SELECT * FROM performance_by_start_year;

-- Salary by Start Year Analysis
DROP TABLE IF EXISTS salary_by_start_year;
CREATE TABLE salary_by_start_year AS
SELECT 
    YEAR(DateOfJoining) AS StartYear,
    AVG(Salary) AS AverageSalary,
    MIN(Salary) AS MinimumSalary,
    MAX(Salary) AS MaximumSalary
FROM 
    employee_data
GROUP BY 
    YEAR(DateOfJoining)
ORDER BY 
    StartYear;

SELECT * FROM salary_by_start_year;

-- Employee Count by Start Year Analysis
DROP TABLE IF EXISTS employees_by_start_year;
CREATE TABLE employees_by_start_year AS
SELECT 
    YEAR(DateOfJoining) AS StartYear,
    COUNT(EmployeeID) AS EmployeeCount
FROM 
    employee_data
GROUP BY 
    YEAR(DateOfJoining)
ORDER BY 
    StartYear;


SELECT * FROM employees_by_start_year;


-- Combined Table by Start Year Analysis
DROP TABLE IF EXISTS table_by_start_year;
CREATE TABLE table_by_start_year AS
SELECT 
    YEAR(DateOfJoining) AS StartYear,
    COUNT(EmployeeID) AS EmployeeCount,
    AVG(Salary) AS AverageSalary,
    MIN(Salary) AS MinimumSalary,
    MAX(Salary) AS MaximumSalary,
    AVG(CASE 
        WHEN PerformanceRating = 'High Performers' THEN 5
        WHEN PerformanceRating = 'Average Performers' THEN 3
        WHEN PerformanceRating = 'Low Performers' THEN 1
        ELSE NULL
    END) AS AveragePerformanceScore
FROM 
    employee_data
GROUP BY 
    YEAR(DateOfJoining)
ORDER BY 
    StartYear;


SELECT * FROM table_by_start_year;