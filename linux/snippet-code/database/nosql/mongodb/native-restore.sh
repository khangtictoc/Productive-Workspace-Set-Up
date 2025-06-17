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
    echo "Restoring $DB..."
    mongorestore mongodb://$USER:$PASSWORD@$HOST:27017/?authSource=admin --nsInclude=$DB.* dump/
done

echo "All restores completed."