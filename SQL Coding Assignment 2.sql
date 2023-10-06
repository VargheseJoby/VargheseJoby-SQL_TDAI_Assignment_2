USE EMPLOYEES;

##How scattered is the man-power for each title?


SELECT 
    T.title AS Title, COUNT(E.emp_no) AS Title_Count
FROM
    titles T
        JOIN
    employees E ON T.emp_no = E.emp_no
WHERE
    to_date LIKE '%9999%'
GROUP BY title
ORDER BY Title_Count;



##How is the salary distribution between titles?


SELECT 
    T.title AS Title,
    ROUND(AVG(S.salary),2) AS Avg_Salary,
    MIN(S.salary) AS Min_Salary,
    MAX(S.salary) AS Max_Salary
FROM
    titles T
        JOIN
    salaries S ON T.emp_no = S.emp_no
GROUP BY Title
ORDER BY Avg_Salary;


##How scattered is the man-power in each department?


SELECT 
    D.dept_name AS Dept_Name,
    COUNT(DE.emp_no) AS Workforce_Count
FROM
    departments D
        JOIN
    dept_emp DE ON D.dept_no = DE.dept_no
GROUP BY Dept_Name
ORDER BY Workforce_Count;



## Who is the highest and lowest paid employee in the company?

## Lowest Paid

SELECT 
    CONCAT(E.first_name, ' ', E.last_name) AS Employee_Name,
    MIN(S.salary) AS Min_Salary_Drawn,
    MAX(S.salary) AS Max_Salary_Drawn
FROM
    employees E
        JOIN
    salaries S ON E.emp_no = S.emp_no
GROUP BY Employee_Name
ORDER BY Min_Salary_Drawn;


## Highest Paid

SELECT 
    CONCAT(E.first_name, ' ', E.last_name) AS Employee_Name,
    MIN(S.salary) AS Min_Salary_Drawn,
    MAX(S.salary) AS Max_Salary_Drawn
FROM
    employees E
        JOIN
    salaries S ON E.emp_no = S.emp_no
GROUP BY Employee_Name
ORDER BY Max_Salary_Drawn desc;


## Who are the managers for each department? List their names


SELECT 
    D.dept_name AS Department_Name,
    CONCAT(E.first_name, ' ', E.last_name) AS Manager_Name,
    DM.from_date AS Effective_From
FROM
    employees E
        JOIN
    dept_manager DM ON E.emp_no = DM.emp_no
        JOIN
    departments D ON DM.dept_no = D.dept_no
WHERE
    DM.to_date LIKE '9999%'
GROUP BY Department_Name;


Using union only command, list all the employees who were hired in 1985, 1989 and 1994 only and sort them by hire dates

SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE '1985%' 
UNION SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE '1989%' 
UNION SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE '1994%'
ORDER BY hire_date;


## What is the average salary of those employees who were hired after 01st Jan 1986?

SELECT 
    ROUND(AVG(S.salary),2) AS Avg_Salary
FROM
    employees E
        JOIN
    salaries S ON E.emp_no = S.emp_no
WHERE
    E.hire_date >= '1986-01-01';


## Is there gender disparity in the company?

SELECT 
    SUM(gender LIKE 'M') AS Total_Male_Employees,
    SUM(gender LIKE 'F') AS Total_Female_Employees
FROM
    employees;



SELECT
    gender,
    COUNT(*) AS gender_count
FROM
    employees
GROUP BY
    gender;
    
    
SELECT
    E.gender,
    COUNT(E.emp_no) AS Total_Empolyees,
    ROUND(AVG(s.salary),2) AS Average_Salary,
    MIN(s.salary) AS Min_Salary,
    MAX(s.salary) AS Max_Salary
FROM
    employees AS E
JOIN
    salaries AS S ON E.emp_no = S.emp_no
GROUP BY
    gender;




## Which department is best paid in the company?


SELECT 
    D.dept_name AS Dept_Name, ROUND(AVG(S.salary),2) AS Avg_Salary
FROM
    salaries S
        JOIN
    dept_emp DE ON S.emp_no = DE.emp_no
        JOIN
    departments D ON DE.dept_no = D.dept_no
GROUP BY Dept_Name
ORDER BY Avg_Salary DESC
LIMIT 1;



SELECT 
    D.dept_name AS Dept_Name, SUM(S.salary) AS Total_Salary
FROM
    salaries S
        JOIN
    dept_emp DE ON S.emp_no = DE.emp_no
        JOIN
    departments D ON DE.dept_no = D.dept_no
GROUP BY Dept_Name
ORDER BY Total_Salary DESC;



SELECT 
    d.dept_no, d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        LEFT JOIN
    dept_emp de ON d.dept_no = de.dept_no
        LEFT JOIN
    salaries s ON de.emp_no = s.emp_no
GROUP BY d.dept_no , d.dept_name
ORDER BY average_salary DESC;



## How has the salary changed over the years?


SELECT 
    YEAR(from_date) AS 'year', ROUND(AVG(salary),2) AS average_salary
FROM
    salaries
GROUP BY YEAR(from_date)
ORDER BY YEAR(from_date);





