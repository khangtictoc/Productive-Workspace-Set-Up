
# Backup
mongodump --uri="<connection_string>" --db databasename
mongodump --uri="<connection_string>" --collection myCollection --db databasename
# Restore
mongorestore <connection_string dump/
mongorestore <connection_string --db databasename dump/