# Upload & download
az storage blob upload --account-name <account-name> --container-name <container-name> --name <destination-file-name> --file <source-file-name>
az storage blob download --account-name <account-name> --container-name <container-name> --name <destination-file-name> --file <source-file-name>

# Check integrity of the file
md5sum --binary <source-file-name> | awk '{print $1}' | xxd -p -r | base64