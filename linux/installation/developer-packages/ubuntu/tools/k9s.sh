#! /bin/bash

if ! command -v k9s 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] k9s"
    wget https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb
    sudo apt install ./k9s_linux_amd64.deb
    echo "==== CLEAN UP ===="
    rm k9s_linux_amd64.deb
else
    echo "- [CHECKED ✅] k9s command exists"
fi