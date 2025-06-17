#!/bin/bash

HOST="<hostname>"
USER="<username>"
PGPASSWORD="<password>"

for FILE in backup-*-*.sql; do
    # Split by '-' and get the second item as database name
    DB=$(echo "$FILE" | cut -d'-' -f2)
    if [[ -n "$DB" ]]; then
        echo "Restoring $DB from $FILE..."
        PGPASSWORD=$PGPASSWORD psql -h $HOST -U $USER -d postgres -c "CREATE DATABASE $DB;"
        PGPASSWORD=$PGPASSWORD psql -h $HOST -U $USER -d $DB < "$FILE"
    else
        echo "Skipping $FILE (could not extract database name)"
    fi
done

echo "All restores completed."