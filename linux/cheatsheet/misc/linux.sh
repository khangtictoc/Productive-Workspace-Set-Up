# View functions's code
declare -f function_name

# -print0 tells find to separate the output with a null character (\0), 
# which is useful for handling filenames with spaces or special characters.
sudo find / -type f -name "*.pdf" -print0 | xargs -0 -I {} cp {} .

## GPG KEY

# Generate GPG key - Interactive
gpg --gen-key

# Generate GPG key - Full featured with more options
gpg --full-generate-key

# List GPG keys
gpg --list-secret-keys

# List keys
gpg --list-keys

# Delete a specific key
gpg --delete-secret-keys <KEY_FINGERPRINT_ID>