#! /bin/bash

if ! command -v ansi 2>&1 >/dev/null
then
    curl -OL git.io/ansi
    sudo chmod 755 ansi
    sudo mv ansi /usr/local/bin/
else
    echo "- [CHECKED ✅] ansi command exists"
