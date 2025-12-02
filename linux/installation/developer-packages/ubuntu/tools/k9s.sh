#! /bin/bash

if ! command -v k9s 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] k9s"
    wget --progress=dot:giga https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb
    sudo apt install ./k9s_linux_amd64.deb

    echo "[INFO] >>>> Clean Up"
    rm k9s_linux_amd64.deb

    if ! command -v k9s &> /dev/null; then
        echo "[FAIL ❌] k9s installation failed!"
        exit 1
    fi

    echo "- [CHECKED ✅] k9s command installed!"
else
    echo "- [CHECKED ✅] k9s command exists"
fi