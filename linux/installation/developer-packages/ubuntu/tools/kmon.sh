#! /bin/bash

if ! command -v kmon 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] kmon"
    wget --progress=dot:giga https://github.com/orhun/kmon/releases/download/v1.7.1/kmon-1.7.1-x86_64-unknown-linux-gnu.tar.gz
    tar -xzf kmon-1.7.1-x86_64-unknown-linux-gnu.tar.gz
    sudo cp kmon-1.7.1/kmon /usr/local/bin/kmon

    echo "[INFO] >>>> Clean Up"
    rm -f kmon-1.7.1-x86_64-unknown-linux-gnu.tar.gz
    rm -drf kmon-1.7.1

    if ! command -v kmon &> /dev/null; then
        echo "[FAIL ❌] kmon installation failed!"
        exit 1
    fi

    echo "- [CHECKED ✅] kmon command installed!"
else
    echo "- [CHECKED ✅] kmon command exists"
fi