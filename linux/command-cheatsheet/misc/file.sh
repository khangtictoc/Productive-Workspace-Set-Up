# find
find <folder> -type f | grep "<pattern>"

# sed
sed -i 's/<old_string>/<new_string>/g' <file>

# rg
## Search with regex in current directory
rg ".*someword.*"
## Search with regex in specific directory
rg ".*someword.*" ./somedir
## Search with regex in specific directory with specific file extensions
rg ".*someword.*" ./somedir -g '*.ps1'

# zip
zip <archive_name>.zip -r * -x <exclude_file_or_folder>