# Search with regex in current directory
rg ".*someword.*"

# Search with regex in specific directory
rg ".*someword.*" ./somedir

# Search with regex in specific directory with specific file extensions
rg ".*someword.*" ./somedir -g '*.ps1'