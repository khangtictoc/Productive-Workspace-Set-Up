## BACKUP & RESTORE

# Bigbang approach
mysqldump -u <USERNAME> -p<PASSWORD> -h <HOST> --skip-lock-tables -B <DATABASE_NAME> -v | gzip > <DATABASE_NAME>_backup_$(date +%Y%d%m).sql 2>/dev/null &
mysqldump --compress --compression-algorithms zlib -u <USERNAME> -p<PASSWORD> -h <HOST> --skip-lock-tables -B <DATABASE_NAME> -v > <DATABASE_NAME>_backup_$(date +%Y%d%m).sql 2>/dev/null &

unzip -p <GUNZIP_FILE>.sql.gz | mysql -u <USERNAME> -p<PASSWORD> -h <HOST> &
gunzip < <GUNZIP_FILE>.sql.gz | mysql -u <USERNAME> -p<PASSWORD> -h <HOST> &
mysql -u <USERNAME> -p<PASSWORD> -h <HOST> < <RESTORE_FILE>.sql &

# Phased-shift approach
mysqldump -u <USERNAME> -p<PASSWORD> <DATABASE_NAME> <TABLE_NAME> > <TABLE_NAME>.sql 

## LOGIN
mysql -u <USERNAME> -p<PASSWORD> -h <HOST> -D <DATABASE_NAME>
