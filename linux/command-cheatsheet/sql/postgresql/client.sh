# Must specify database name
PGPASSWORD=<password> psql -h <hostname> -d <database> 
PGPASSWORD=<password> psql -h <hostname> -U <username> -d <database> -c "\l"
PGPASSWORD=<password> psql -h <hostname> -U <username> -d <database> -c "CREATE DATABASE bytebase;"

dropdb -f dbname