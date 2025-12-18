#! /bin/bash

VERSION="v3.0.1"

if ! command -v asciinema 2>&1 >/dev/null
then
    curl -L  "https://github.com/asciinema/asciinema/releases/download/v3.0.1/asciinema-x86_64-unknown-linux-musl" --output asciinema
    sudo install asciinema /usr/local/bin/asciinema
    echo "[INFO] >>>> Clean Up"
    rm asciinema

    if ! command -v asciinema &> /dev/null; then
        echo "[FAIL ❌] asciinema installation failed!"
        exit 1
    fi

    echo "- [CHECKED ✅] asciinema command installed!"
else
    echo "- [CHECKED ✅] asciinema command exists!"
fi