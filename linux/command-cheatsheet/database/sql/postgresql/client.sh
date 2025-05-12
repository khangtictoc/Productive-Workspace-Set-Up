# Must specify database name
PGPASSWORD=<password> psql -h <hostname> -U <username> -d <database> -c "\l"
PGPASSWORD=<password> psql -h <hostname> -U <username> -d <database> -c "CREATE DATABASE bytebase;"

# Backup
## Linux
PGPASSWORD=<password> pg_dump -h <hostname> -U <username> -d <database> > backup.sql
PGPASSWORD=<password> pg_dump -h <hostname> -U <username> -d <database> --schema-only > backup.sql
PGPASSWORD=<password> pg_dump -h <hostname> -U <username> -d <database> --data-only > backup.sql
PGPASSWORD=<password> pg_dump -h <hostname> -U <username> -d <database> --no-owner> backup.sql
## Windows
pg_dump -h <hostname> -U <username> -d <database> -W > backup.sql
pg_dump -h <hostname> -U <username> -d <database> -W --schema-only > backup.sql
pg_dump -h <hostname> -U <username> -d <database> -W --data-only > backup.sql
pg_dump -h <hostname> -U <username> -d <database> -W --no-owner > backup.sql

## Restore
PGPASSWORD=<password> psql -h <hostname> -U <username> -d uat2_united_tracking_db < backup.sql

# Interactice shell
## Connection
\c <database>;
## Delete DB
dropdb -f dbname;
## View tables
\dt;