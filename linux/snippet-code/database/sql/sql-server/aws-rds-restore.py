import time
databases = [
    "<DATABASE_NAME1>",
    "<DATABASE_NAME2>",
]

timestr = time.strftime("%Y%m%d-%H%M%S")
with open(f'aws-restore-{timestr}.sql', 'w+') as file:
    for database in databases:
        sql = f"""
EXEC msdb.dbo.rds_restore_database @restore_db_name='{database}', @s3_arn_to_restore_from='arn:aws:s3:::rs-backup-aws-sql-server/united/{database}/backup-20250512-175732.bak';
go
"""
        file.write(sql + '\n')