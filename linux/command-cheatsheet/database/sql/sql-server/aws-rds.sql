-- DATABASE
EXEC msdb.dbo.rds_drop_database N'<your-database-name>';
EXEC rdsadmin.dbo.rds_modify_db_name '<your-database-name-old>', '<your-database-name-new>'
EXEC rdsadmin.dbo.rds_set_database_offline '<your-database-name>';
EXEC rdsadmin.dbo.rds_set_database_online '<your-database-name>';


-- Backup database
exec msdb.dbo.rds_backup_database
    @source_db_name='your_database_name',
    @s3_arn_to_backup_to='arn:aws:s3:::rs-backup-aws-sql-server/dxpro-uat/saPickingUAT.bak',
    @overwrite_s3_backup_file=1,
    @type='FULL';

-- Restore database
EXEC msdb.dbo.rds_restore_database @restore_db_name = '<your-database-name>', 
@s3_arn_to_restore_from = 'arn:aws:s3:::<bucket-name>/<folder-path>/<your-backup>.bak';
EXEC msdb.dbo.rds_restore_database @restore_db_name = '<your-database-name>', @s3_arn_to_restore_from = 'arn:aws:s3:::<bucket-name>/<folder-path>/<your-backup>.bak';

-- TASK
-- View status
exec msdb.dbo.rds_task_status @task_id = 1;

-- Cancel task
exec msdb.dbo.rds_cancel_task @task_id = 1;
