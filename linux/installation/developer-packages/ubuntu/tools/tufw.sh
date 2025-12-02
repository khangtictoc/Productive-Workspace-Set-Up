#! /bin/bash

if ! command -v tufw 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] tufw"
    wget --progress=dot:giga https://github.com/peltho/tufw/releases/download/v0.2.4/tufw_0.2.4_linux_amd64.deb
    sudo dpkg -i tufw_0.2.4_linux_amd64.deb

    echo "[INFO] >>>> Clean Up"
    rm -f tufw_0.2.4_linux_amd64.deb

    if ! command -v tufw &> /dev/null; then
        echo "[FAIL ❌] tufw installation failed!"
        exit 1
    fi

    echo "- [CHECKED ✅] tufw command installed!"
else
    echo "- [CHECKED ✅] tufw command exists"
fi