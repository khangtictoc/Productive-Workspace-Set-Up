#! /bin/bash

VERSION="0.26.1"

if ! command -v bat 2>&1 >/dev/null
then
    wget --progress=dot:giga  https://github.com/sharkdp/bat/releases/download/v${VERSION}/bat_${VERSION}_amd64.deb
    sudo dpkg -i bat_${VERSION}_amd64.deb

    echo "[INFO] >>>> Clean Up"
    rm bat_${VERSION}_amd64.deb

    if ! command -v bat &> /dev/null; then
        echo "[FAIL ❌] bat installation failed!"
        exit 1
    fi

    echo "[CHECKED ✅] bat command installed!"
else
    echo "[CHECKED ✅] bat command exists"
fi