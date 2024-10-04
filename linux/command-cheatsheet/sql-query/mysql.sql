// https://devhints.io/mysql

CREATE USER 'newmatomo'@'%' IDENTIFIED  BY 'eL9KaXe1jdv44Byd7Szf';
GRANT ALL PRIVILEGES ON *.* TO 'matomobackupuser'@'%';
FLUSH PRIVILEGES;

SELECT COLUMN_NAME
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = 'user' AND TABLE_NAME = 'my_table';
SELECT host, user, max_connections, max_user_connections, plugin, password_expired, default_role from mysql.user;  

SELECT table_schema "DB Name",
        ROUND(SUM(data_length + index_length) / 1024 / 1024, 1) "DB Size in MB" 
FROM information_schema.tables 
GROUP BY table_schema; 

SHOW VARIABLES LIKE '%bind%'
SHOW VARIABLES WHERE Variable_name = 'innodb_buffer_pool_size'
OR Variable_name = 'innodb_log_file_size'
OR Variable_name = 'max_allowed_packet'
OR Variable_name = 'innodb_flush_log_at_trx_commit'
OR Variable_name = 'innodb_thread_concurrency'
OR Variable_name = 'innodb_doublewrite';