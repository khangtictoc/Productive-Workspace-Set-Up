-- https://devhints.io/mysql
-- Create login user & grant permissions
CREATE USER '<NEW_USER>'@'%' IDENTIFIED  BY ' ';
GRANT ALL PRIVILEGES ON *.* TO '<NEW_USER>'@'%';
FLUSH PRIVILEGES;

-- Version
SELECT VERSION();

-- Tables
SELECT
  TABLE_NAME AS `Table`,
  ROUND(DATA_LENGTH / 1024 / 1024, 1) AS "Data Size (MB)",
  ROUND(INDEX_LENGTH / 1024 / 1024, 1) AS "Index Size (MB)",
  ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024) AS `Total (MB)`
FROM
  information_schema.TABLES
WHERE
  TABLE_SCHEMA = "<TABLE_NAME>"
HAVING
  `Total (MB)` > 0
ORDER BY
  (DATA_LENGTH + INDEX_LENGTH)
DESC;

-- Columns
SELECT COLUMN_NAME, TABLE_NAME, TABLE_CATALOG, TABLE_SCHEMA
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE COLUMN_NAME LIKE '%list%';

-- Thread & performance
SELECT * FROM performance_schema.threads;
SELECT * FROM INFORMATION_SCHEMA.PROCESSLIST;

-- Files log (May consumes lots of disk space)
SHOW BINARY LOGS;
PURGE BINARY LOGS TO 'mysql-bin.000223';
PURGE BINARY LOGS BEFORE DATE(NOW() - INTERVAL 3 DAY) + INTERVAL 0 SECOND;

-- Clear cache
FLUSH TABLES;

-- Get users & check privileges
SELECT host, user, max_connections, max_user_connections, Show_db_priv, plugin, password_expired from mysql.user;  
SHOW GRANTS FOR '<USER_NAME>'@'localhost'; 
SHOW GRANTS FOR '<USER_NAME>'@'%'; 

-- Database size 
SELECT table_schema "DB Name", 
  ROUND(SUM(data_length) / 1024 / 1024, 1) AS "Data Size in MB",
  ROUND(SUM(index_length) / 1024 / 1024, 1) AS "Index Size in MB",
  ROUND(SUM(data_length + index_length) / 1024 / 1024, 1) AS "Total DB Size in MB" 
FROM information_schema.tables 
GROUP BY table_schema; 

-- Server configuration variables
SET GLOBAL log_bin = 'OFF';
SHOW VARIABLES LIKE '%bin%';
SHOW VARIABLES WHERE Variable_name = 'innodb_buffer_pool_size'
OR Variable_name = 'innodb_log_file_size'
OR Variable_name = 'max_allowed_packet'
OR Variable_name = 'innodb_flush_log_at_trx_commit'
OR Variable_name = 'innodb_thread_concurrency'
OR Variable_name = 'innodb_doublewrite';