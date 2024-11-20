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
with open(f'change_recovery_model-{timestr}.sql', 'w+') as file:
    for database in databases:
        sql = f"""
USE [{database}];
GO
ALTER DATABASE [{database}]
SET RECOVERY SIMPLE;
GO
        """
        file.write(sql + '\n')