#!/bin/bash

HOST="<hostname>"
USER="<username>"
PASSWORD="<password>"
DATABASES=(
    "db1"
) # Add your database names here

# Date format
DATE=$(date +%F)

for DB in "${DATABASES[@]}"
do
    echo "Backing up $DB..."
    mongodump --uri="mongodb://$USER:$PASSWORD@$HOST:27017" --db $DB
done

echo "All backups completed."