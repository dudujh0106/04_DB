-- 심화 1
-- 1번
USE sqldb;
SELECT * FROM usertbl;
SHOW INDEX FROM usertbl;
SHOW TABLE STATUS LIKE 'usertbl';

-- 2번
CREATE INDEX idx_usertbl_addr ON usertbl(addr);
SHOW INDEX FROM usertbl;

-- 3번
SHOW TABLE STATUS LIKE 'usertbl';
ANALYZE TABLE usertbl;
SHOW TABLE STATUS LIKE 'usertbl';

-- 4번
CREATE UNIQUE INDEX idx_usertbl_birthYear ON usertbl(birthYear);
-- 중복된 값이 존재하여 인덱스 생성 에러 발생
CREATE INDEX idx_usertbl_nam ON usertbl(name);
SHOW INDEX FROM usertbl;

-- 5번
DROP INDEX idx_usertbl_nam ON usertbl;
CREATE INDEX idx_usertbl_name_birthYear ON usertbl(name, birthYear);
SHOW INDEX FROM usertbl;

-- 6번
DROP INDEX idx_usertbl_addr ON usertbl;
DROP INDEX idx_usertbl_name_birthYear ON usertbl;
SHOW INDEX FROM usertbl;

-- 심화 2
-- 1번
CREATE DATABASE scoula_db;

CREATE USER 'scoula'@'%' IDENTIFIED BY '1234';
-- 패스워드 변경 시
-- ALTER USER 'scoula'@'%' IDENTIFIED BY '1234';

GRANT ALL privileges ON scoula_db.* TO 'scoula'@'%';
GRANT ALL privileges ON sqldb.* TO 'scoula'@'%';
FLUSH privileges;