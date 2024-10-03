// https://devhints.io/mysql

CREATE USER 'matomobackupuser'@'localhost' IDENTIFIED  BY 'eL9KaXe1jdv44Byd7Szf';
GRANT ALL PRIVILEGES ON *.* TO 'matomobackupuser'@'localhost';
FLUSH PRIVILEGES;
SELECT user from mysql.user;  

SELECT table_schema "DB Name",
        ROUND(SUM(data_length + index_length) / 1024 / 1024, 1) "DB Size in MB" 
FROM information_schema.tables 
GROUP BY table_schema; 