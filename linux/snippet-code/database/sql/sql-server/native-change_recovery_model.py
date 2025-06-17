import time
databases = [
    "<DATABASE_NAME1>",
    "<DATABASE_NAME2>",
]
timestr = time.strftime("%Y%m%d-%H%M%S")
with open(f'native-change_recovery_model-{timestr}.sql', 'w+') as file:
    for database in databases:
        sql = f"""
USE [{database}];
GO
ALTER DATABASE [{database}]
SET RECOVERY SIMPLE;
GO
        """
        file.write(sql + '\n')