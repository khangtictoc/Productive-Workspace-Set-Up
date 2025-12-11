#! /bin/bash

if ! command -v bat 2>&1 >/dev/null
then
    curl -OL --progress=dot:giga https://github.com/sharkdp/bat/releases/download/v0.26.1/bat_0.26.1_amd64.deb
    sudo dpkg -i bat_0.26.1_amd64.deb

    echo "[INFO] >>>> Clean Up"
    rm bat_0.26.1_amd64.deb

    if ! command -v bat &> /dev/null; then
        echo "[FAIL ❌] bat installation failed!"
        exit 1
    fi

    echo "- [CHECKED ✅] bat command installed!"
else
    echo "- [CHECKED ✅] bat command exists"
fi