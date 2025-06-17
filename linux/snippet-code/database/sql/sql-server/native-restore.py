import time 

source_db = [
    "<DATABASE_NAME1>",
    "<DATABASE_NAME2>",
]

destinated_db = [
    "<DATABASE_NAME1_RESTORED>",
    "<DATABASE_NAME2_RESTORED>",
]

timestr = time.strftime("%Y%m%d-%H%M%S")
with open(f'native-restore-{timestr}.sql', 'w+') as file:
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