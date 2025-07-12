import time 

databases = [
    "<DATABASE_NAME1>",
    "<DATABASE_NAME2>",
]

timestr = time.strftime("%Y%m%d-%H%M%S")
with open(f'native-shrink_log_files-{timestr}.sql', 'w+') as file:
    for database in databases:
        sql = f"""
USE [{database}];
GO
DBCC SHRINKFILE (N'{database}' , 0, TRUNCATEONLY)
GO
       """
        file.write(sql + '\n')