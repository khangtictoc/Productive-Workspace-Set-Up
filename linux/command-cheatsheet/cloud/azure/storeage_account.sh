# Upload & download
az storage blob upload --account-name bigymigrationbackup  --container-name matomo --name matomo_backup_prod_20240710.sql --file matomo_backup_prod_20240710.sql
az storage blob download --account-name bigymigrationbackup --container-name matomo --name matomo_backup_prod_20240710.sql --file matomo_backup_prod_20240710.sql

# Check integrity of the file
md5sum --binary matomo-minimal-codebase.zip | awk '{print $1}' | xxd -p -r | base64