DROP TABLE titles

CREATE TABLE titles (

	emp_no INT NOT NULL,

	title VARCHAR NOT NULL,

	from_date DATE NOT NULL,

	to_date DATE NOT NULL,

	PRIMARY KEY (emp_no, from_date)

);

SELECT * FROM dept_emp

DROP TABLE dept_emp

CREATE TABLE dept_emp (

	emp_no INT NOT NULL,

	dept_no INT NOT NULL,

	from_date DATE NOT NULL,

	to_date DATE NOT NULL,

	PRIMARY KEY (emp_no, dept_no)

);

DROP TABLE dept_emp

CREATE TABLE dept_emp (

	emp_no INT NOT NULL,

	dept_no VARCHAR NOT NULL,

	from_date DATE NOT NULL,

	to_date DATE NOT NULL,

	PRIMARY KEY (emp_no, dept_no)

);

SELECT * FROM titles

SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Finding retiring employees born only in 1952

SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Finding retiring employees born only in 1953

SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Finding retiring employees born only in 1954

SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Finding retiring employees born only in 1955

SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility

SELECT first_name, last_name

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring

SELECT COUNT(first_name)

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Complete list of employees retiring 

SELECT first_name, last_name

INTO retirement_info

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info

DROP TABLE retirement_info

-- Create new table for retiring employees. 

SELECT emp_no, first_name, last_name

INTO retirement_info

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table

SELECT * FROM retirement_info

-- Joining departments and dept_manager tables

SELECT departments.dept_name,

	dept_manager.emp_no,
	
	dept_manager.from_date,
	
	dept_manager.to_date
	
FROM departments

INNER JOIN dept_manager

ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables 

SELECT retirement_info.emp_no,

	retirement_info.first_name,
	
retirement_info.last_name,

	dept_emp.to_date
	
FROM retirement_info

LEFT JOIN dept_emp

ON retirement_info.emp_no = dept_emp.emp_no

-- Joining retirement_info and dept_emp tables SHORTENED

SELECT ri.emp_no,

	ri.first_name,
	
ri.last_name,

	de.to_date
	
FROM retirement_info as ri

LEFT JOIN dept_emp as de

ON ri.emp_no = de.emp_no

-- Joining departments and dept_manager tables with ~alias~

SELECT d.dept_name,

	dm.emp_no,
	
	dm.from_date,
	
	dm.to_date
	
FROM departments as d

INNER JOIN dept_manager as dm

ON d.dept_no = dm.dept_no;

-- Joining retirement info and dept_emp tables ~alias~

SELECT ri.emp_no,

	ri.first_name,
	
	ri.last_name,
	
de.to_date

INTO current_emp

FROM retirement_info as ri

LEFT JOIN dept_emp as de

ON ri.emp_no = de.emp_no

WHERE de.to_date = ('9999-01-01');

SELECT * FROM current_emp

-- Employee count by department number

SELECT COUNT(ce.emp_no), de.dept_no

INTO retiring_dept

FROM current_emp as ce

LEFT JOIN dept_emp as de

ON ce.emp_no = de.emp_no

GROUP BY de.dept_no

ORDER BY de.dept_no;

-- Collecting Salary information 

SELECT * FROM salaries

ORDER BY to_date DESC;

-- Joining ri and em, adding gender then 3rd table - This is a mess and needs to be cleaned up...

SELECT e.emp_no,

	first_name,
	
last_name,

	gender,
	
		s.salary,
	
	de.to_date
	
--INTO emp_info
	
--FROM employees

--WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

--AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

FROM employees as e

INNER JOIN salaries as s

ON (e.emp_no = s.emp_no)

INNER JOIN dept_emp as de

ON (e.emp_no = de.emp_no)



--SELECT * FROM emp_info

--SELECT e.emp_no,

--	e.first_name,
	
--e.last_name,

--	e.gender,
	
--	s.salary,
	
--	de.to_date
	
--INTO emp_info

--FROM employee as e

--INNER JOIN salaries as s

--ON (e.emp_no = s.emp_no)

--INNER JOIN dept_emp as de

--ON (e.emp_no = de.emp_no)

WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')

	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	
AND (de.to_date = '9999-01-01')

-- Cleaned version of 3 table join

SELECT e.emp_no,

	first_name,
	
last_name,

	gender,
	
		s.salary,
	
	de.to_date
	
INTO emp_info2

FROM employees as e

INNER JOIN salaries as s

ON (e.emp_no = s.emp_no)

INNER JOIN dept_emp as de

ON (e.emp_no = de.emp_no)

WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')

	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	
AND (de.to_date = '9999-01-01')

SELECT * FROM emp_info2

-- List of managers per department 

SELECT dm.dept_no,

	d.dept_name,
	
	dm.emp_no, 
	
	ce.last_name,
	
	ce.first_name,
	
	dm.from_date,
	
	dm.to_date
	
INTO manager_info

FROM dept_manager AS dm

	INNER JOIN departments AS d
	
		ON (dm.dept_no = d.dept_no)
		
	INNER JOIN current_emp AS ce
	
		ON (dm.emp_no = ce.emp_no);
		
-- Department Retirees
		
SELECT ce.emp_no,

ce.first_name,

ce.last_name,

d.dept_name

INTO dept_info

FROM current_emp as ce

INNER JOIN dept_emp AS de

ON (ce.emp_no = de.emp_no)

INNER JOIN departments AS d

ON (de.dept_no = d.dept_no);

-- Sales retirement info

SELECT ri.emp_no,

	ri.first_name,
	
	ri.last_name,
	
	di.dept_name
	
INTO sales_ret
	
FROM retirement_info AS ri

INNER JOIN dept_info AS di

ON ri.emp_no = di.emp_no

WHERE di.dept_name = ('Sales');

-- Sales and Development Retirees 

SELECT ri.emp_no,

	ri.first_name,
	
	ri.last_name,
	
	di.dept_name
	
INTO sales_dev_ret
	
FROM retirement_info AS ri

INNER JOIN dept_info AS di

ON ri.emp_no = di.emp_no

WHERE di.dept_name IN ('Sales', 'Development');

SELECT * FROM sales_dev_ret

-- Deliverable 1

SELECT em.emp_no,

	em.first_name, 
	
	em.last_name,
	
	t.title,
	
	t.from_date,
	
	t.to_date
	
INTO retirement_titles

FROM employees AS em

INNER JOIN titles AS t

ON em.emp_no = t.emp_no

WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31');

-- Showing the retirement_titles table for viewing 

SELECT * FROM retirement_titles

-- Adding Distinct On to remove duplicate emp_no

SELECT

	DISTINCT ON
	(emp_no) emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date
	
FROM retirement_titles

ORDER BY 
	emp_no;
	
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, first_name DESC;

SELECT * FROM current_ret 

-- Finding department retirement quantities 

SELECT

	COUNT(title),
	title
	
INTO retiring_titles

FROM current_ret

GROUP BY title

ORDER BY count DESC;

DROP TABLE test_one

-- Mentorship Eligibility

SELECT * FROM employees

SELECT e.emp_no,

	e.first_name,
	
	e.last_name,
	
	e.birth_date,
	
	de.from_date,
	
de.to_date

INTO test
	
FROM employees as e

INNER JOIN dept_emp as de 

ON e.emp_no = de.emp_no

SELECT * FROM test

SELECT tt.emp_no,

	tt.first_name,
	
	tt.last_name,
	
	tt.birth_date,
	
	tt.from_date,
	
	tt.to_date,
	
	titl.title
	
INTO test2

FROM test as tt

INNER JOIN titles as titl

ON tt.emp_no = titl.emp_no

SELECT * FROM test2

SELECT DISTINCT ON(emp_no) emp_no,

first_name,

last_name,

birth_date,

from_date,

to_date,

title

INTO mentorship_eligibility

FROM test2

WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')

AND to_date = ('9999-01-01')

ORDER BY emp_no, first_name DESC;

SELECT * FROM dept_emp

WHERE to_date = ('9999-01-01')



