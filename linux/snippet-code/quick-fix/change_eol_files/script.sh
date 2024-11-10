find linux/alias -iname ".*" -type f | xargs -I {} bash -c "dos2unix {}"
find linux/start  -type f | xargs -I {} bash -c "dos2unix {}"