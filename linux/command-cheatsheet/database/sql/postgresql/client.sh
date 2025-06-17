# Must specify database name
PGPASSWORD=<password> psql -h <hostname> -U <username> -d postgres -c "\l"
PGPASSWORD=<password> psql -h <hostname> -U <username> -d postgres -c "CREATE DATABASE <database>;"
PGPASSWORD=<password> psql -h <hostname> -U <username> -d postgres -c "DROP DATABASE <database>;"
PGPASSWORD=<password> psql -h <hostname> -U <username> -d postgres -c "\l"

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

# Restore
PGPASSWORD=<password> psql -h <hostname> -U <username> -d <database> < backup.sql

# Interactive shell
## Connection
\c <database>;
## Delete DB
dropdb -f dbname;
## View tables
\dt;