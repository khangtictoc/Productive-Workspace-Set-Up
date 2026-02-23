#! /bin/bash

TAWS_VERSION="v1.3.0-rc.4"

if ! command -v taws 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] taws"
    wget --progress=dot:giga \
        "https://github.com/huseyinbabal/taws/releases/download/$TAWS_VERSION/taws-x86_64-unknown-linux-musl.tar.gz"
    sudo tar -xzf taws-x86_64-unknown-linux-musl.tar.gz -C /usr/local/bin taws
    sudo chmod +x /usr/local/bin/taws

    echo "[INFO] >>>> Clean Up"
    rm taws-x86_64-unknown-linux-musl.tar.gz

    if ! command -v taws &> /dev/null; then
        echo "[FAIL ❌] taws installation failed!"
        exit 1
    fi

    echo "[CHECKED ✅] taws command installed!"
else
    echo "[CHECKED ✅] taws command exists"
fi