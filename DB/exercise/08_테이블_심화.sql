-- 심화 1
USE tabledb;
-- 1번
DROP TABLE IF EXISTS buytbl;
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl(
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    birthYear   INT NOT NULL
);
CREATE TABLE buytbl(
   num         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   userID      CHAR(8) NOT NULL,
   prodName    CHAR(6) NOT NULL,
   FOREIGN KEY(userid) REFERENCES usertbl(userID)
);

-- 2번
DROP TABLE IF EXISTS buytbl;
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl(
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    birthYear   INT NOT NULL,
    email       CHAR(30) NULL UNIQUE
);

-- 3번
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl(
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10),
    birthYear   INT CHECK (birthYear >= 1900 AND birthYear <= 2023),
    mobile      CHAR(3) NOT NULL
);

-- 4번
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl(
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    birthYear   INT NOT NULL DEFAULT -1,
    addr        CHAR(2) NOT NULL DEFAULT '서울',
    mobile1     CHAR(3) NULL,
    mobile2     CHAR(8) NULL,
    height      SMALLINT NULL DEFAULT 170,
    mDate       DATE NULL
);
INSERT INTO usertbl VALUES('LSG', '이승기', default, default, '011', '1111111', default, '2008-8-8');

-- 5번
ALTER TABLE usertbl DROP COLUMN mobile1;
ALTER TABLE usertbl CHANGE COLUMN name uName VARCHAR(10) NOT NULL;
ALTER TABLE usertbl DROP PRIMARY KEY;

-- 심화 2
USE employees;
-- 1번
CREATE VIEW employees_info
AS
SELECT e.*, title, t.from_date AS t_from, t.to_date AS t_to, salary, s.from_date AS s_from, s.to_date AS s_to FROM employees e
INNER JOIN titles t ON e.emp_no = t.emp_no
INNER JOIN salaries s ON e.emp_no = s.emp_no;

-- 2번
SELECT * FROM employees_info
WHERE s_to = '9999-01-01';

-- 3번
DROP VIEW IF EXISTS emp_dept_info;
CREATE VIEW emp_dept_info
AS
SELECT emp_no, dept_emp.dept_no, dept_name, from_date, to_date FROM dept_emp
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
ORDER BY emp_no;

-- 4번
SELECT * FROM emp_dept_info
WHERE to_date = '9999-01-01';
