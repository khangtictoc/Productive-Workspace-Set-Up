-- https://devhints.io/mysql
-- CREATE LOGIN USER & GRANT PERMISSIONS
CREATE USER 'newmatomo'@'%' IDENTIFIED  BY 'eL9KaXe1jd5t4Byd7Szf';
GRANT ALL PRIVILEGES ON *.* TO 'abc1233'@'%';
FLUSH PRIVILEGES;

-- GET COLUMNS OF TABLE
SELECT COLUMN_NAME, TABLE_NAME, TABLE_CATALOG, TABLE_SCHEMA
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE COLUMN_NAME LIKE '%list%';

-- THREAD & PERFORMANCE
SELECT * FROM performance_schema.threads;
SELECT * FROM INFORMATION_SCHEMA.PROCESSLIST;

-- FILES LOG (May consumes lots of disk space)
SHOW BINARY LOGS;
PURGE BINARY LOGS TO 'mysql-bin.000223';
PURGE BINARY LOGS BEFORE DATE(NOW() - INTERVAL 3 DAY) + INTERVAL 0 SECOND;

-- GET USERS
SELECT host, user, max_connections, max_user_connections, Show_db_priv, plugin, password_expired from mysql.user;  

-- DATABASE SIZE 
SELECT table_schema "DB Name",
        ROUND(SUM(data_length + index_length) / 1024 / 1024, 1) "DB Size in MB" 
FROM information_schema.tables 
GROUP BY table_schema; 

-- SERVER CONFIGURATION VARIABLES
SHOW VARIABLES LIKE '%bind%'
SHOW VARIABLES WHERE Variable_name = 'innodb_buffer_pool_size'
OR Variable_name = 'innodb_log_file_size'
OR Variable_name = 'max_allowed_packet'
OR Variable_name = 'innodb_flush_log_at_trx_commit'
OR Variable_name = 'innodb_thread_concurrency'
OR Variable_name = 'innodb_doublewrite';