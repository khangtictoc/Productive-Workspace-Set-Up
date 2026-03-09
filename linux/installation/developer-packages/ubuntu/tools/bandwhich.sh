#! /bin/bash

BANDWIDTH_CLI_VERION=0.23.1

if ! command -v bandwhich 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] bandwhich"
    wget https://github.com/imsnif/bandwhich/releases/download/v$BANDWIDTH_CLI_VERION/bandwhich-v$BANDWIDTH_CLI_VERION-x86_64-unknown-linux-gnu.tar.gz
    tar -xzf bandwhich-v$BANDWIDTH_CLI_VERION-x86_64-unknown-linux-gnu.tar.gz
    sudo cp bandwhich /usr/local/bin/bandwhich
    echo "[INFO] >>>> Clean Up"
    rm -f bandwhich-v$BANDWIDTH_CLI_VERION-x86_64-unknown-linux-gnu.tar.gz bandwhich

    if ! command -v bandwhich &> /dev/null; then
        echo "[FAIL ❌] bandwhich installation failed!"
        exit 1
    fi

    echo "[CHECKED ✅] bandwhich command installed!"
else
    echo "[CHECKED ✅] bandwhich command exists"
fi