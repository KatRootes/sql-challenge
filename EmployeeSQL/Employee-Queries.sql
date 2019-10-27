-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT emp_no AS "Employee Number", last_name AS "Last Name", first_name AS "First Name", gender AS "Gender",
	(
		SELECT "Salaries".salary
	 	FROM "Salaries"
	 	WHERE "Employees".emp_no = "Salaries".emp_no
	) AS "Salary" 
FROM "Employees";

-- 2. List employees who were hired in 1986.
SELECT emp_no AS "Employee Number", last_name AS "Last Name", first_name AS "First Name", hire_date AS "Hire Date"
FROM "Employees"
WHERE EXTRACT(year FROM hire_date) = 1986;

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

-- QUESTION:  List the Complete History or just the current managers?

-- Here is the HISTORY
SELECT dpt.dept_no AS "Department Number", dpt.dept_name AS "Department Name", dptMgr.emp_no AS "Manager Number", emp.last_name AS "Last Name", emp.first_name AS "First Name", dptMgr.from_date AS "Start Date", dptMgr.to_date AS "End Date"
FROM "Departments" AS dpt, "Dep_Manager" AS dptMgr, "Employees" AS emp
WHERE dpt.dept_no = dptMgr.dept_no AND dptMgr.emp_no = emp.emp_no;

-- Here is just the current
SELECT dpt.dept_no AS "Department Number", dpt.dept_name AS "Department Name", dptMgr.emp_no AS "Manager Number", emp.last_name AS "Last Name", emp.first_name AS "First Name", dptMgr.from_date AS "Start Date", dptMgr.to_date AS "End Date"
FROM "Departments" AS dpt, "Dep_Manager" AS dptMgr, "Employees" AS emp
WHERE dpt.dept_no = dptMgr.dept_no AND dptMgr.emp_no = emp.emp_no AND EXTRACT(year FROM dptMgr.to_date)=9999;


-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

-- QUESTION:  Is this currently or ever?

-- Here is the History
SELECT emp.emp_no AS "Employee Number", emp.last_name AS "Last Name", emp.first_name AS "First Name", dpt.dept_name AS "Department Name"
FROM "Departments" AS dpt, "Dep_Emp" AS dptEmp, "Employees" AS emp
WHERE dpt.dept_no = dptEmp.dept_no AND dptEmp.emp_no = emp.emp_no; 

-- Here is current
SELECT emp.emp_no AS "Employee Number", emp.last_name AS "Last Name", emp.first_name AS "First Name", dpt.dept_name AS "Department Name"
FROM "Departments" AS dpt, "Dep_Emp" AS dptEmp, "Employees" AS emp
WHERE dpt.dept_no = dptEmp.dept_no AND dptEmp.emp_no = emp.emp_no  AND EXTRACT(year FROM dptEmp.to_date)=9999;


-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT emp_no AS "Employee Number", first_name AS "First Name", last_name AS "Last Name"
FROM "Employees"
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

-- QUESTION:  Is this currently or ever?

-- Here is the History
SELECT emp.emp_no AS "Employee Number", emp.last_name AS "Last Name", emp.first_name AS "First Name", dpt.dept_name AS "Department Name"
FROM "Employees" AS emp, "Departments" AS dpt, "Dep_Emp" AS dptEmp
WHERE dpt.dept_no = dptEmp.dept_no AND dptEmp.emp_no = emp.emp_no AND dpt.dept_name = 'Sales';

-- Here is the current
SELECT emp.emp_no AS "Employee Number", emp.last_name AS "Last Name", emp.first_name AS "First Name", dpt.dept_name AS "Department Name"
FROM "Employees" AS emp, "Departments" AS dpt, "Dep_Emp" AS dptEmp
WHERE dpt.dept_no = dptEmp.dept_no AND dptEmp.emp_no = emp.emp_no AND dpt.dept_name = 'Sales' AND EXTRACT(year FROM dptEmp.to_date)=9999;

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name

-- QUESTION:  Is this currently or ever?

-- Here is the History
SELECT emp.emp_no AS "Employee Number", emp.last_name AS "Last Name", emp.first_name AS "First Name", dpt.dept_name AS "Department Name"
FROM "Employees" AS emp, "Departments" AS dpt, "Dep_Emp" AS dptEmp
WHERE dpt.dept_no = dptEmp.dept_no AND dptEmp.emp_no = emp.emp_no AND (dpt.dept_name = 'Sales' OR dpt.dept_name = 'Development');

-- Here is the current
SELECT emp.emp_no AS "Employee Number", emp.last_name AS "Last Name", emp.first_name AS "First Name", dpt.dept_name AS "Department Name"
FROM "Employees" AS emp, "Departments" AS dpt, "Dep_Emp" AS dptEmp
WHERE dpt.dept_no = dptEmp.dept_no AND dptEmp.emp_no = emp.emp_no AND (dpt.dept_name = 'Sales' OR dpt.dept_name = 'Development') AND EXTRACT(year FROM dptEmp.to_date)=9999;

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name AS "Last Name", COUNT(last_name) AS "Count"
FROM "Employees"
GROUP BY last_name
ORDER BY "Count" DESC;