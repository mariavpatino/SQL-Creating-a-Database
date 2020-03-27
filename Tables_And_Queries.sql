-- Create Departments Table
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
	dept_no VARCHAR(4) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(30) NOT NULL
);

-- Create Department Employees Table
DROP TABLE IF EXISTS dept_emp;
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

-- Create Department Managers Table
DROP TABLE IF EXISTS dept_manager;
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

-- Create Employees Table
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	birth_date VARCHAR(30) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(1) NOT NULL,
	hire_date VARCHAR(30) NOT NULL
);

-- Create Salaries Table
DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

-- Create Titles Table
DROP TABLE IF EXISTS titles;
CREATE TABLE titles (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	title VARCHAR(30) NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
);

-- Query: SELECT * FROM Each Table To Confirm Data
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;


-- Data Analysis

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", 
	   e.gender As "Gender", s.salary AS "Salary"
FROM salaries s
INNER JOIN employees e 
	ON e.emp_no = s.emp_no;
	

-- 2. List employees who were hired in 1986.
SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';


-- 3. List the manager of each department with the following information: department number, department name, 
--    the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no AS "Department Number", d.dept_name AS "Department Name", m.emp_no AS "Managers Employee Number", 
	   e.last_name AS "Last Name", e.first_name AS "First Name", m.from_date AS "Start Employment Date", 
	   m.to_date AS "End Employment Date"
FROM departments d
INNER JOIN dept_manager m 
	ON m.dept_no = d.dept_no
JOIN employees e 
	ON e.emp_no = m.emp_no;
	

-- 4. List the department of each employee with the following information: employee number, last name, first name, 
-- and department name.
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", 
	   dp.dept_name AS "Department Name"
FROM employees e
INNER JOIN dept_emp de
	ON e.emp_no = de.emp_no
INNER JOIN departments dp 
	ON dp.dept_no = de.dept_no;
	

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name AS "First Name", last_name as "Last Name"
FROM employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';


-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", dp.dept_name AS "Department Name"
FROM employees e
INNER JOIN dept_emp de 
	ON e.emp_no = de.emp_no
INNER JOIN departments dp 
	ON dp.dept_no = de.dept_no
WHERE dp.dept_name LIKE 'Sales';


-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", dp.dept_name AS "Department Name"
FROM employees e
INNER JOIN dept_emp de 
	ON e.emp_no = de.emp_no
INNER JOIN departments dp 
	ON dp.dept_no = de.dept_no
WHERE dp.dept_name LIKE 'Sales'
OR dp.dept_name LIKE 'Development';


-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name AS "Last Name", COUNT(*) AS "Frequency"
FROM employees
GROUP BY last_name
ORDER BY "Frequency" DESC;









