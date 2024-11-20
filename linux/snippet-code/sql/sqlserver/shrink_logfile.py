import itertools 
import time 

databases = [
    'Stg-BigYAsset',
    'Stg-BigYCart',
    'Stg-BigYCMS',
    'Stg-BigYDevice',
    'Stg-BigYCentral',
    'Stg-BigYDistributionCore',
    'Stg-BigYList',
    'Stg-BigYIdentity',
    'Stg-BigYOrder',
    'Stg-BigYProduct',
    'Stg-BigYOffer',
    'Stg-BigYRelationshop',
    'Stg-BigYSCPickup',
    'Stg-BigYSetting',
    'Stg-BigYStore',
    'Stg-BigYv6-Hangfire-WeedklyAd',
    'Stg-BigYRSCMS',
    'Stg-BigYStaging',
    'Stg-BigYRelationshopV2',
    'Stg-BigYAttribute',
    'Stg-BigYv6-HangfireV2',
    'Stg-BigYReward',
]

timestr = time.strftime("%Y%m%d-%H%M%S")
with open(f'restore-{timestr}.sql', 'w+') as file:
    for database in databases:
        datafile_name = database.split('-')[1]
        logfile_name = datafile_name + "_log"
        sql = f"""
USE [{database}];
GO
DBCC SHRINKFILE ({logfile_name}, 1)
GO
       """
        file.write(sql + '\n')