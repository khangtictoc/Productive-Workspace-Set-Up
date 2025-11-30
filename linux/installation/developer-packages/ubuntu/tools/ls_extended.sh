#! /bin/bash

if ! command -v ls_extended 2>&1 >/dev/null
then
    git clone https://github.com/Chirag-Khandelwal/ls_extended.git
    ./ls_extended/build.sh
    sudo cp ls_extended/bin/ls_extended /usr/local/bin
    echo "==== CLEAN UP ===="
    rm -drf ls_extended
    echo "- [CHECKED ✅] ls_extended command installed!"
else
    echo "- [CHECKED ✅] ls_extended command exists"
fi
