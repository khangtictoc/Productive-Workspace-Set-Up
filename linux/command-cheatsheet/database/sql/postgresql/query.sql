SELECT * FROM pg_stat_activity WHERE datname = 'dbname';
SELECT datname FROM pg_database;
DROP DATABASE dbname WITH (FORCE);