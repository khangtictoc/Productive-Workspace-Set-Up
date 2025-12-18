#! /bin/bash

GO_VERSION=1.24.5

if ! command -v go 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Go"
      "https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"
    tar xfvz go$GO_VERSION.linux-amd64.tar.gz
    cp go/bin/* /usr/local/bin/

    echo "[INFO] >>>> Clean Up"
    rm -drf go$GO_VERSION.linux-amd64.tar.gz go

    if ! command -v go &> /dev/null; then
        echo "[FAIL ❌] go installation failed!"
        exit 1
    fi

    echo "- [CHECKED ✅] go command installed!"
else
    echo "- [CHECKED ✅] go command exists"
fi