
# Backup
mongodump --uri="<connection_string>" --db <database_name>
mongodump --uri="<connection_string>" --collection <collection_name> --db <database_name>
# Restore
mongorestore <connection_string> /dump
mongorestore <connection_string> --nsInclude=<database>.* /dump
mongorestore <connection_string> --nsInclude=<database>.<collection> /dump