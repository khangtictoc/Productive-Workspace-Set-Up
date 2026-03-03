#! /bin/bash

KMON_CLI_VERION=1.7.1

if ! command -v kmon 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] kmon"
    wget --progress=dot:giga https://github.com/orhun/kmon/releases/download/v$KMON_CLI_VERION/kmon-$KMON_CLI_VERION-x86_64-unknown-linux-gnu.tar.gz
    tar -xzf kmon-$KMON_CLI_VERION-x86_64-unknown-linux-gnu.tar.gz
    sudo cp kmon-$KMON_CLI_VERION/kmon /usr/local/bin/kmon

    echo "[INFO] >>>> Clean Up"
    rm -f kmon-$KMON_CLI_VERION-x86_64-unknown-linux-gnu.tar.gz
    rm -drf kmon-$KMON_CLI_VERION

    if ! command -v kmon &> /dev/null; then
        echo "[FAIL ❌] kmon installation failed!"
        exit 1
    fi

    echo "[CHECKED ✅] kmon command installed!"
else
    echo "[CHECKED ✅] kmon command exists"
fi