find . -iname ".*" -type f | xargs -I {} bash -c "dos2unix {}"
find . -iname "*.sh" -type f | xargs -I {} bash -c "dos2unix {}"