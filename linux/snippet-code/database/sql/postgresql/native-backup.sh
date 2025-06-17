#!/bin/bash

HOST="<hostname>"
USER="<username>"
PGPASSWORD="<password>"
DATABASES=(
    "db1"
) # Add your database names here

# Date format
DATE=$(date +%F)

for DB in "${DATABASES[@]}"
do
    echo "Backing up $DB..."
    PGPASSWORD=$PGPASSWORD pg_dump -h $HOST -U $USER -d $DB > "backup-${DB}-${DATE}.sql"
done

echo "All backups completed."