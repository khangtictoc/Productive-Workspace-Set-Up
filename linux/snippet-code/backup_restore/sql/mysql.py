import time
import os

db_user = 'newmatomo'
db_password = 'eL9KaXe1jdv44Byd7Szf'
db_host = '192.168.20.84'
db_name = 'matomo1'
output_dir = "matomodb"

tables = [
'matomo_archive_blob_2021_01',    
'matomo_log_link_visit_action',   
'matomo_log_visit',               
'matomo_log_form_page',           
'matomo_log_form',                
'matomo_log_conversion',          
'matomo_archive_blob_2024_01',    
'matomo_log_action',              
'matomo_archive_blob_2024_04',    
'matomo_archive_blob_2024_05',    
'matomo_archive_blob_2024_03',    
'matomo_archive_blob_2023_12',    
'matomo_archive_blob_2024_02',    
'matomo_archive_blob_2024_07',    
'matomo_archive_blob_2023_10',    
'matomo_archive_blob_2024_06',    
'matomo_archive_blob_2023_09',    
'matomo_archive_blob_2024_08',    
'matomo_archive_blob_2023_11',    
'matomo_archive_blob_2024_09',    
'matomo_log_conversion_item',     
'matomo_archive_blob_2024_10',    
'matomo_log_form_field',          
'matomo_archive_blob_2023_01',    
'matomo_archive_blob_2020_08',    
'matomo_archive_blob_2022_01',    
'matomo_archive_blob_2023_07',    
'matomo_archive_blob_2023_06',    
'matomo_archive_blob_2023_04',    
'matomo_archive_blob_2023_08',    
'matomo_archive_blob_2023_03',    
'matomo_archive_blob_2023_05',    
'matomo_archive_blob_2023_02',    
'matomo_archive_blob_2022_06',    
'matomo_archive_blob_2022_07',    
'matomo_archive_blob_2022_08',    
'matomo_archive_blob_2022_05',    
'matomo_archive_blob_2022_11',    
'matomo_archive_blob_2022_09',    
'matomo_archive_blob_2022_12',    
'matomo_archive_blob_2022_10',    
'matomo_archive_blob_2021_02',    
'matomo_archive_blob_2022_04',    
'matomo_archive_blob_2021_03',    
'matomo_archive_blob_2021_05',    
'matomo_archive_blob_2021_04',    
'matomo_archive_blob_2021_08',    
'matomo_archive_blob_2021_09',    
'matomo_archive_blob_2021_06',    
'matomo_archive_blob_2021_07',    
'matomo_archive_blob_2021_11',    
'matomo_archive_blob_2021_10',    
'matomo_archive_blob_2021_12',    
'matomo_archive_blob_2022_03',    
'matomo_archive_blob_2022_02',    
'matomo_archive_numeric_2024_01', 
'matomo_archive_numeric_2024_05', 
'matomo_archive_numeric_2024_04', 
'matomo_archive_numeric_2024_03', 
'matomo_archive_numeric_2024_02', 
'matomo_session',                 
'matomo_archive_numeric_2023_12', 
'matomo_archive_numeric_2023_10', 
'matomo_archive_blob_2020_11',    
'matomo_archive_numeric_2023_09', 
'matomo_archive_blob_2020_12',    
'matomo_archive_numeric_2023_11', 
'matomo_archive_blob_2020_10',    
'matomo_archive_numeric_2024_06', 
'matomo_archive_blob_2020_09',    
'matomo_archive_numeric_2024_09', 
'matomo_archive_numeric_2023_07', 
'matomo_archive_numeric_2024_07', 
'matomo_archive_numeric_2023_08', 
'matomo_archive_numeric_2024_08', 
'matomo_archive_numeric_2023_06', 
'matomo_archive_numeric_2021_01', 
'matomo_archive_numeric_2021_02', 
'matomo_archive_numeric_2024_10', 
'matomo_archive_numeric_2023_05', 
'matomo_archive_numeric_2023_01', 
'matomo_archive_numeric_2023_02', 
'matomo_archive_numeric_2023_04', 
'matomo_archive_numeric_2023_03', 
'matomo_archive_numeric_2022_12', 
'matomo_archive_numeric_2022_07', 
'matomo_archive_numeric_2022_11', 
'matomo_archive_numeric_2021_03', 
'matomo_archive_numeric_2022_08', 
'matomo_archive_numeric_2021_10', 
'matomo_archive_numeric_2020_09', 
'matomo_archive_numeric_2022_09', 
'matomo_archive_numeric_2021_11', 
'matomo_archive_numeric_2022_06', 
'matomo_archive_numeric_2020_10', 
'matomo_archive_numeric_2021_05', 
'matomo_archive_numeric_2022_10', 
'matomo_archive_numeric_2022_05', 
'matomo_archive_numeric_2021_09', 
'matomo_archive_numeric_2021_04', 
'matomo_archive_numeric_2020_11', 
'matomo_archive_numeric_2022_04', 
'matomo_archive_numeric_2021_06', 
'matomo_archive_numeric_2020_08', 
'matomo_archive_numeric_2022_01', 
'matomo_archive_numeric_2021_08', 
'matomo_archive_numeric_2022_03', 
'matomo_archive_numeric_2020_12', 
'matomo_archive_numeric_2021_12', 
'matomo_archive_numeric_2021_07', 
'matomo_archive_numeric_2022_02', 
'matomo_option',                  
'matomo_log_media',               
'matomo_archive_numeric_2020_07', 
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