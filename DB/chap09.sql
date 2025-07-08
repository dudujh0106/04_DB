CREATE DATABASE scoula_db;

CREATE USER 'scoula'@'%' IDENTIFIED BY '1234';
-- 패스워드 변경 시
-- ALTER USER 'scoula'@'%' IDENTIFIED BY '1234';

GRANT ALL privileges ON scoula_db.* TO 'scoula'@'%';
GRANT ALL privileges ON sqldb.* TO 'scoula'@'%';
FLUSH privileges;