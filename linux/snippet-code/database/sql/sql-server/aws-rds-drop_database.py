import time
databases = [
    "<DATABASE_NAME1>",
    "<DATABASE_NAME2>",
]

timestr = time.strftime("%Y%m%d-%H%M%S")
with open(f'aws-delete-{timestr}.sql', 'w+') as file:
    for database in databases:
        sql = f"""
EXECUTE msdb.dbo.rds_drop_database  N'{database}';
go
"""
        file.write(sql + '\n')