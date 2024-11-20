import itertools 
import time 

source_db = [
    'BigYv6-Asset',
    'BigYv6-Cart',
    'BigYv6-CMS',
    'BigYv6-Device',
    'BigYv6-Central',
    'BigYv6-DistributionCore',
    'BigYv6-List',
    'BigYv6-Identity',
    'BigYv6-RSCMS',
    'BigYv6-Order',
    'BigYv6-Product',
    'BigYv6-Offer',
    'BigYv6-Relationshop',
    'BigYv6-SCPickup',
    'BigYv6-Setting',
    'BigYv6-Staging',
    'BigYv6-Store',
    'BigYv6-RelationshopV2',
    'BigYv6-Attribute',
    'BigYv6-HangfireV2',
    'BigYv6-Hangfire-WeedklyAd',
    'BigYv6-Reward',
]
destinated_db = [
    'Stg-BigYAsset',
    'Stg-BigYCart',
    'Stg-BigYCMS',
    'Stg-BigYDevice',
    'Stg-BigYCentral',
    'Stg-BigYDistributionCore',
    'Stg-BigYList',
    'Stg-BigYIdentity',
    'Stg-BigYRSCMS',
    'Stg-BigYOrder',
    'Stg-BigYProduct',
    'Stg-BigYOffer',
    'Stg-BigYRelationshop',
    'Stg-BigYSCPickup',
    'Stg-BigYSetting',
    'Stg-BigYStaging',
    'Stg-BigYStore',
    'Stg-BigYRelationshopV2',
    'Stg-BigYAttribute',
    'Stg-BigYv6-HangfireV2',
    'Stg-BigYv6-Hangfire-WeedklyAd',
    'Stg-BigYReward', 
]

timestr = time.strftime("%Y%m%d-%H%M%S")
with open(f'restore-{timestr}.sql', 'w+') as file:
    for src, dest in zip(source_db, destinated_db):
        datafile_name = src.split('-')[1]
        logfile_name = datafile_name + "_log"
        sql = f"""
RESTORE DATABASE [{dest}]  
FROM DISK = 'D:\SQLBackup\BigYProduction\{src}\\backup-20241115-114905.bak' 
WITH MOVE '{datafile_name}' TO 'D:\SQLData\{dest}.mdf', 
     MOVE '{logfile_name}' TO 'D:\SQLData\{dest}_0.ldf'
        """
        file.write(sql + '\n')