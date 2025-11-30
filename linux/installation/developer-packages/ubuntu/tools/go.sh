#! /bin/bash

GO_VERSION=1.24.5

if ! command -v go 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Go"
    wget --progress=dot:giga "https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"
    tar xfvz go$GO_VERSION.linux-amd64.tar.gz
    cp go/bin/* /usr/local/bin/
    echo "==== CLEAN UP ===="
    rm -drf go$GO_VERSION.linux-amd64.tar.gz go
    echo "- [CHECKED ✅] go command installed!"
else
    echo "- [CHECKED ✅] go command exists"
fi