#! /bin/bash

DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

if ! command -v dive 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] dive"
    curl -OL https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb
    sudo apt install ./dive_${DIVE_VERSION}_linux_amd64.deb
    echo "==== CLEAN UP ===="
    rm -f dive_${DIVE_VERSION}_linux_amd64.deb
else
    echo "- [CHECKED ✅] dive command exists"
fi