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
    echo "Dropping database $DB..."
    PGPASSWORD=$PGPASSWORD psql -h $HOST -U $USER -d postgres -c "DROP DATABASE $DB;"
done

echo "All drop operations completed."