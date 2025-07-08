USE sqldb;

SELECT * FROM buytbl
INNER JOIN usertbl
ON buytbl.userID = usertbl.userID
ORDER BY buytbl.userID;