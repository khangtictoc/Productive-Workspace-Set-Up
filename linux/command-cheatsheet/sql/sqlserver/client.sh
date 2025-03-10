# Restore a database from a SQL Server backup file
sqlcmd -S prd-dxpro-us-east-1-rds-ms-sql-1.mercatus.com \
-U temp \
-P notrealpassword \
-d MTOrder \
-i script.sql
