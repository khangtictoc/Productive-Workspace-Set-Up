# Restore a database from a SQL Server backup file
sqlcmd -S uat-dxpro-us-east-1-rds-ms-sql-1.mercatus.com \
-U srn_db_admin \
-P KhpRCwP3ycOs4dX9H227 \
-d UAT-MTOrder \
-i script.sql \
-C  # Skip SSL certificate verification

uat-dxpro-us-east-1-rds-pg-sql