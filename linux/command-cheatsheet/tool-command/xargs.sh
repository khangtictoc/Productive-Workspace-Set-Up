# -print0 tells find to separate the output with a null character (\0), 
# which is useful for handling filenames with spaces or special characters.
sudo find / -type f -name "*.pdf" -print0 | xargs -0 -I {} cp {} .