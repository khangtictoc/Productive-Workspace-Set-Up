-- DATABASE
-- Delete database
EXEC msdb.dbo.rds_drop_database N'UAT-MTPicking';

EXEC msdb.dbo.rds_restore_database @restore_db_name='UAT-MTPicking', @s3_arn_to_restore_from='arn:aws:s3:::dxpro-data-migration/mssql-backup/saPickingUAT.bak';

-- TASK
exec msdb.dbo.rds_task_status @task_id=38;

select name FROM sys.databases;

exec msdb.dbo.rds_backup_database
@source_db_name='mydatabase',
@s3_arn_to_backup_to='arn:aws:s3:::dxpro-data-migration/mssql-backup/.bak',


 sqlcmd -S uat-dxpro-us-east-1-rds-ms-sql-1.mercatus.com -U srn_db_admin -P KhpRCwP3ycOs4dX9H227


-- USER
-- Show all users
SELECT * FROM sys.database_principals;
