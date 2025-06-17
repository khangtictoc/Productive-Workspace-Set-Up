-- DATABASE
-- Delete database
EXEC msdb.dbo.rds_drop_database N'<your-database-name>';

-- Restore database
EXEC msdb.dbo.rds_restore_database @restore_db_name = '<your-database-name>', 
@s3_arn_to_restore_from = 'arn:aws:s3:::<bucket-name>/<folder-path>/<your-backup>.bak';
EXEC msdb.dbo.rds_restore_database @restore_db_name = '<your-database-name>', @s3_arn_to_restore_from = 'arn:aws:s3:::<bucket-name>/<folder-path>/<your-backup>.bak';

-- TASK
-- View status
exec msdb.dbo.rds_task_status @task_id = 1;

-- Cancel task
exec msdb.dbo.rds_cancel_task @task_id = 1;
