# View functions's code
declare -f function_name

# -print0 tells find to separate the output with a null character (\0), 
# which is useful for handling filenames with spaces or special characters.
sudo find / -type f -name "*.pdf" -print0 | xargs -0 -I {} cp {} .

## GPG KEY

# Generate GPG key - Interactive
gpg --gen-key

# Generate GPG key - Full options
gpg --full-generate-key

# List GPG keys
gpg --list-secret-keys

# List keys
gpg --list-keys

# Delete a specific key
gpg --delete-secret-keys <KEY_FINGERPRINT_ID>


## FILE

# find
find <folder> -type f | grep "<pattern>"

# sed
sed -i 's/<old_string>/<new_string>/g' <file>

## RIPGREP

# Search regex + current directory
rg ".*someword.*"

# Search regex + directory
rg ".*someword.*" ./somedir

# Search regex + directory + file extensions
rg ".*someword.*" ./somedir -g '*.ps1'


## ZIP
zip <archive_name>.zip -r * -x <exclude_file_or_folder>

## KERNEL LOGS

dmesg

## Format Filesystem
mkfs

## FILE SYSTEMS

# View mounted filesystems
mount | column -t
lsblk
cat /etc/fstab # Configuration for at Boot time

# Check Device for specific mount path
df -h /home/virus 
findmnt -n -o SOURCE -T /home/virus