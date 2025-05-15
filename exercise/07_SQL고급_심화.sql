-- 심화 1
USE sqldb;
-- 1-1번
SELECT stdtbl.stdName, addr, clubtbl.clubName, roomNo FROM stdtbl
LEFT JOIN stdclubtbl ON stdtbl.stdName = stdclubtbl.stdName
LEFT JOIN clubtbl ON stdclubtbl.clubName = clubtbl.clubName;
-- 1-2번
SELECT clubtbl.clubName, roomNo, stdclubtbl.stdName, addr FROM clubtbl
LEFT JOIN stdclubtbl ON clubtbl.clubName = stdclubtbl.clubName
LEFT JOIN stdtbl ON stdclubtbl.stdName = stdtbl.stdName;
-- 2-1번
SELECT B.emp AS 부하직원, A.emp AS 직속상관, A.emptel AS 직속상관연락처 FROM emptbl A
INNER JOIN emptbl B ON A.emp = B.manager
WHERE B.emp = '우대리';

-- 심화 2
USE employees;
-- 1번
SELECT employees.emp_no, first_name, last_name, title FROM employees
INNER JOIN titles ON employees.emp_no = titles.emp_no
WHERE to_date='9999-01-01';
-- 2번
SELECT employees.*, title, salary FROM employees
INNER JOIN titles ON employees.emp_no = titles.emp_no
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE titles.to_date='9999-01-01' AND salaries.to_date='9999-01-01';
-- 3번
SELECT employees.emp_no, first_name, last_name, dept_name FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date='9999-01-01'
ORDER BY emp_no;
-- 4번
SELECT departments.dept_no, dept_name, count(*) FROM departments
INNER JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date='9999-01-01'
GROUP BY departments.dept_no
ORDER BY dept_no;
-- 5번
SELECT employees.emp_no, first_name, last_name, dept_name, from_date, to_date FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.emp_no = 10209
ORDER BY from_date;


