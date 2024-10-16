import time
backup_dir = 'D:\SQLBackup\cloudmigration'
databases = [
    'UnitedStore1',
    'UnitedStore2',
    'UnitedStore3',
    'UnitedStore4',
    'UnitedStore5',
]
timestr = time.strftime("%Y%m%d-%H%M%S")
with open(f'backup-sqlserver-{timestr}.sql', 'w+') as file:
    for database in databases:
        sql = f"""
USE "{database}";
GO
EXECUTE master.dbo.xp_create_subdir '{backup_dir}\{database}'
BACKUP DATABASE "{database}"
TO DISK = '{backup_dir}\{database}\\backup-{timestr}.bak'
   WITH FORMAT,
      MEDIANAME = 'SQLServerBackups',
      NAME = 'Full Backup of {database}';
PRINT 'Finish backing up database {database} to {backup_dir}\{database}\\backup-{timestr}.bak'
GO
        """
        file.write(sql + '\n')