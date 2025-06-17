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
    echo "Dropping database $DB..."
    mongosh "mongodb://$USER:$PASSWORD@$HOST:27017/$DB?authSource=admin" --eval "db.dropDatabase()"
done

echo "All drop operations completed."