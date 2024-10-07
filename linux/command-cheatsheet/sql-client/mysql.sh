# Backup & Restore
mysqldump -u newmatomo -peL9KaXe1jdv44Byd7Szf -h 192.168.20.84 --skip-lock-tables -B matomo1 -v | gzip > matomo_backup_prod_$(date +%Y%d%m).sql 2>/dev/null &
mysqldump --compress --compression-algorithms zlib -u newmatomo -peL9KaXe1jdv44Byd7Szf -h 192.168.20.84 --skip-lock-tables -B matomo1 -v > matomo_backup_prod_$(date +%Y%d%m).sql 2>/dev/null &
unzip -p matomo_backup_prod_20240410.sql.gz | mysql -u root -pabc1233 -h mysql-dxp-matomo-bigy-sandbox-primary.dxp-matomo.svc.cluster.local &
gunzip < matomo_backup_prod_20240410.sql.gz | mysql -u root -pabc1233 -h mysql-dxp-matomo-bigy-sandbox-primary.dxp-matomo.svc.cluster.local &