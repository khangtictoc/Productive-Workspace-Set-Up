#! /bin/bash

if ! command -v bandwhich 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] bandwhich"
    wget --progress=dot:giga https://github.com/imsnif/bandwhich/releases/download/v0.23.1/bandwhich-v0.23.1-x86_64-unknown-linux-gnu.tar.gz
    tar -xzf bandwhich-v0.23.1-x86_64-unknown-linux-gnu.tar.gz
    sudo cp bandwhich /usr/local/bin/bandwhich
    echo "[INFO] >>>> Clean Up"
    rm -f bandwhich-v0.23.1-x86_64-unknown-linux-gnu.tar.gz bandwhich

    if ! command -v bandwhich &> /dev/null; then
        echo "[FAIL ❌] bandwhich installation failed!"
        exit 1
    fi

    echo "- [CHECKED ✅] bandwhich command installed!"
else
    echo "- [CHECKED ✅] bandwhich command exists"
fi