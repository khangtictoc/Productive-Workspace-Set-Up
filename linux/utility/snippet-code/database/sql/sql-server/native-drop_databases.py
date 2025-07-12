import time
databases = [
    "<DATABASE_NAME1>",
    "<DATABASE_NAME2>",
]
timestr = time.strftime("%Y%m%d-%H%M%S")
with open(f'native-delete-{timestr}.sql', 'w+') as file:
    for database in databases:
        sql = f"""DROP DATABASE [{database}];"""
        file.write(sql + '\n')