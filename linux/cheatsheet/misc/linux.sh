## ----- SYSTEM ------

# View functions's code
declare -f <function_name>

## Kernel logs
dmesg

## Format Filesystem
mkfs

## ----- GPG KEY ------

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


## ----- FILE -----

# find
find <folder> -type f | grep "<pattern>"

# sed
sed -i 's/<old_string>/<new_string>/g' <file_name>

## rg (ripgrep)

# Search regex + current directory
rg ".*someword.*"

# Search regex + directory
rg ".*someword.*" <folder_name>

# Search regex + directory + file extensions
rg ".*someword.*" <folder_name> -g '*.ps1'

# -print0 tells find to separate the output with a null character (\0), 
# which is useful for handling filenames with spaces or special characters.

sudo find / -type f -name "*.pdf" -print0 | xargs -0 -I {} cp {} .

## zip

zip <archive_name>.zip -r * -x <exclude_file_or_folder>

## ----- FILE SYSTEMS -----

# View mounted filesystems
mount | column -t
lsblk
cat /etc/fstab # Configuration for at Boot time

# Check Device for specific mount path
df -h [<mount_path>]
findmnt -n -o SOURCE -T <mount_path>


# Safe delete a file (No way to recover)
shred -u <file_name>

## ----- STRING -----

##  grep

# OR operator
grep '<string1>\|<string2>' <file_name>

# Find string in all files in all subdirectories.
grep -rl "<string>" <path>

# Basic Regex (Perl)
grep -P '<regex>' <file_name>