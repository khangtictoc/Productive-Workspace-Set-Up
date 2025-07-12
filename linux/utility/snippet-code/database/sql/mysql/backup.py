import time
import os

db_user = '<your_db_user>'
db_password = '<your_db_password>'
db_host = '<your_db_host>'
db_name = '<your_db_name>'
output_dir = "matomodb"

tables = [
    "table1",
    "table2",
]
timestr = time.strftime("%Y%m%d-%H%M%S")

if not os.path.exists(output_dir):
    os.makedirs(output_dir)
    print(f"Directory '{output_dir}' created.")
else:
    print(f"Directory '{output_dir}' already exists.")

## BACKUP

flag_user = f"-u {db_user}" if db_user != '' else ''
flag_password = f"-p{db_password}" if db_password != '' else ''
flag_host = f"-h {db_host}" if db_host != '' else ''


with open(f'{output_dir}/backup-mysql-{timestr}.sh', 'w+') as file:
    for tbl in tables:
        sql = f"""mysqldump {flag_user} {flag_password} {flag_host} --skip-lock-tables {db_name} {tbl} > matomo_backup_prod_{tbl}_{timestr}.sql &"""
        file.write(sql + '\n')