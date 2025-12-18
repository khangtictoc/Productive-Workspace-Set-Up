#! /bin/bash

if ! command -v mongo 2>&1 >/dev/null && ! command -v mongosh 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] MongoDB CLI Tools"
    ## MongoDB Database Tools
      "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb"       
    dpkg -i mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb
    
    echo "[INFO] >>>> Clean Up"
    rm -f mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb

    ## MongoDB Shell (mongosh)
      -qO- https://www.mongodb.org/static/pgp/server-8.0.asc \
        |  tee /etc/sudo apt/trusted.gpg.d/server-8.0.asc
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/sudo apt/ubuntu noble/mongodb-org/8.0 multiverse" \
        | tee /etc/sudo apt/sources.list.d/mongodb-org-8.0.list
    sudo apt-get update
    sudo apt-get install -y mongodb-mongosh

    if ! command -v mongo &> /dev/null && ! command -v mongosh &> /dev/null; then
        echo "[FAIL ❌] mongo/mongosh installation failed!"
        exit 1
    fi

    echo "- [CHECKED ✅] mongo + mongosh command installed!"
else
    echo "- [CHECKED ✅] mongo + mongosh command exists"
fi