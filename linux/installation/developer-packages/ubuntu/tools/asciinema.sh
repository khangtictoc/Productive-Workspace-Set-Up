#! /bin/bash

VERSION="v3.0.1"

if ! command -v asciinema 2>&1 >/dev/null
then
    curl -L --progress-bar "https://github.com/asciinema/asciinema/releases/download/v3.0.1/asciinema-x86_64-unknown-linux-musl" --output asciinema
    sudo install asciinema /usr/local/bin/asciinema
    echo "==== CLEAN UP ===="
    rm asciinema
    echo "- [CHECKED ✅] asciinema command installed!"
else
    echo "- [CHECKED ✅] asciinema command exists!"
fi