SELECT * FROM pg_stat_activity WHERE datname = 'dbname';
SELECT datname FROM pg_database;
DROP DATABASE dbname WITH (FORCE);


SELECT
    datname AS database_name,
    pg_size_pretty(pg_database_size(datname)) AS size
FROM
    pg_database
WHERE datname like 'uat2_united%'
ORDER BY
pg_database_size(datname) DESC;
