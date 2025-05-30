-- DATABASE
-- Delete database
EXEC msdb.dbo.rds_drop_database N'your-database-name';
-- Restore database
EXEC msdb.dbo.rds_restore_database @restore_db_name='saPickingUAT', 
@s3_arn_to_restore_from='arn:aws:s3:::dxpro-data-migration/mssql-backup/saPickingUAT.bak';
-- TASK
exec msdb.dbo.rds_task_status @task_id=33;

EXEC msdb.dbo.rds_restore_database @restore_db_name='UnitedDistributionCore', @s3_arn_to_restore_from='arn:aws:s3:::rs-backup-aws-sql-server/united/UnitedDistributionCore/backup-20250512-101220.bak';