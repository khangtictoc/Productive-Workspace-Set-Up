#! /bin/bash

MONGO_CLI_VERSION=100.12.2
MONGOSH_CLI_VERSION=8.0

if ! command -v mongo 2>&1 >/dev/null || ! command -v mongosh 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] MongoDB CLI Tools"
    ## MongoDB Database Tools
    wget --progress=dot:giga "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-$MONGO_CLI_VERSION.deb"       
    dpkg -i mongodb-database-tools-ubuntu2204-x86_64-$MONGO_CLI_VERSION.deb
    
    echo "[INFO] >>>> Clean Up"
    rm -f mongodb-database-tools-ubuntu2204-x86_64-$MONGO_CLI_VERSION.deb

    ## MongoDB Shell (mongosh)
    wget --progress=dot:giga -qO- https://www.mongodb.org/static/pgp/server-$MONGOSH_CLI_VERSION.asc \
        |  tee /etc/apt/trusted.gpg.d/server-$MONGOSH_CLI_VERSION.asc
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/$MONGOSH_CLI_VERSION multiverse" \
        | tee /etc/apt/sources.list.d/mongodb-org-$MONGOSH_CLI_VERSION.list
    sudo apt-get update
    sudo apt-get install -y mongodb-mongosh

    if ! command -v mongo &> /dev/null &> /dev/null; then
        echo "[FAIL ❌] mongo installation failed!"
        exit 1
    fi

    echo "[CHECKED ✅] mongo command installed!"

    if ! command -v mongosh &> /dev/null; then
        echo "[FAIL ❌] mongosh installation failed!"
        exit 1
    fi

    echo "[CHECKED ✅] mongosh command installed!"
else
    echo "[CHECKED ✅] mongo + mongosh command exists"
fi