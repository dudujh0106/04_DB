-- sqldb 데이터베이스에서 다음 조건을 처리
USE sqldb;
-- 1-1번
SELECT * FROM buytbl
INNER JOIN usertbl
ON buytbl.userID = usertbl.userID;
-- 1-2번
SELECT * FROM buytbl
INNER JOIN usertbl
ON buytbl.userID = usertbl.userID
WHERE buytbl.userID = 'JYP';
-- 2번
SELECT usertbl.userID, name, prodName, addr, CONCAT(mobile1, mobile2) AS 연락처 FROM usertbl
LEFT JOIN buytbl
ON usertbl.userID = buytbl.userID
ORDER BY usertbl.userID;
-- 3-1번
SELECT * FROM usertbl
WHERE userID NOT IN (SELECT userID FROM usertbl WHERE mobile1 IS NULL);
-- 3-2번
SELECT * FROM usertbl
WHERE userID IN (SELECT userID FROM usertbl WHERE mobile1 IS NULL);