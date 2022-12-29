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

SELECT * FROM mentorship_eligibility