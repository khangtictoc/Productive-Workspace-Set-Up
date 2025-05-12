import time
backup_dir = 'D:\SQLBackup\cloudmigration'
databases = [
    'UAT2-UnitedPunchCard',
    'UAT2-UnitedOffer',
    'UAT2-UnitedIdentity',
    'UAT2-UnitedAsset',
    'UAT2-UnitedCart',
    'UAT2-UnitedCentral',
    'UAT2-UnitedCMS',
    'UAT2-UnitedList',
    'UAT2-UnitedOrder',
    'UAT2-UnitedProduct',
    'UAT2-UnitedRelationshop',
    'UAT2-UnitedStore',
    'UAT2-UnitedSCPickup',
    'UAT2-UnitedSetting',
    'UAT2-UnitedHangfire',
    'UAT2-United-RSCMS',
    'UAT2-UnitedAttribute',
    'UAT2-UnitedApiGateway',
    'UAT2-UnitedDevice',
    'UAT2-UnitedDistributionCore',
    'UAT2-UnitedStaging',
]

timestr = time.strftime("%Y%m%d-%H%M%S")
with open(f'backup-{timestr}.sql', 'w+') as file:
    for database in databases:
        sql = f"""
EXEC msdb.dbo.rds_restore_database @restore_db_name='{database}', @s3_arn_to_restore_from='arn:aws:s3:::rs-backup-aws-sql-server/united/{database}/backup-20250512-175732.bak';
go
"""
        file.write(sql + '\n')