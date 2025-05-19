-- 1-1번
DROP DATABASE IF EXISTS tabledb;
CREATE DATABASE tabledb;
USE tabledb;

-- 1-2번
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl(
    userID      CHAR(8) NOT NULL PRIMARY KEY,
    name        VARCHAR(10) NOT NULL,
    birthYear   INT NOT NULL,
    addr        CHAR(2) NOT NULL,
    mobile1     CHAR(3) NULL,
    mobile2     CHAR(8) NULL,
    height      SMALLINT NULL,
    mDate       DATE NULL
);

-- 2번
DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl(
   num         INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   userid      CHAR(8) NOT NULL,
   prodName    CHAR(6) NOT NULL,
   groupName   CHAR(4) NULL,
   price       INT NOT NULL,
   amount      SMALLINT NOT NULL,
   FOREIGN KEY(userid) REFERENCES usertbl(userID)
);

-- 3-1번
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');

-- 3-2번
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
-- 오류 발생 : userid 컬럼이 참조하는 테이블 usertbl의 컬럼 userID에 'JYP'가 없음
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);

-- 4번
DROP TABLE IF EXISTS buytbl;
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl(
    userID      CHAR(8) NOT NULL,
    name        VARCHAR(10) NOT NULL,
    birthYear   INT NOT NULL,
    CONSTRAINT PRIMARY KEY PK_usertbl_userID(userID)
);

-- 5번
DROP TABLE IF EXISTS prodTbl;
CREATE TABLE prodTbl(
    prodCode    CHAR(3) NOT NULL,
    prodID      CHAR(4) NOT NULL,
    prodDate    DATE NOT NULL,
    proCur      CHAR(10) NULL,
    CONSTRAINT PRIMARY KEY PK_prodTbl_prodCode_prodID(prodCode, prodID)
);

-- 6-1번
DROP VIEW IF EXISTS v_user;
CREATE VIEW v_user
AS
SELECT usertbl.userid, name, prodName, addr, CONCAT(mobile1, mobile2) AS 연락처 FROM usertbl
INNER JOIN buytbl ON usertbl.userID = buytbl.userid;

-- 6-2번
SELECT * FROM v_user
WHERE name = '김범수';