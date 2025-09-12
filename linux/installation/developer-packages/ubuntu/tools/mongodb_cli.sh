#! /bin/bash

## MongoDB Database Tools
wget "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb"       
dpkg -i mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb
echo "==== CLEAN UP ===="
rm -f mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb

## MongoDB Shell (mongosh)
wget -qO- https://www.mongodb.org/static/pgp/server-8.0.asc |  tee /etc/sudo apt/trusted.gpg.d/server-8.0.asc
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/sudo apt/ubuntu noble/mongodb-org/8.0 multiverse" | tee /etc/sudo apt/sources.list.d/mongodb-org-8.0.list
sudo apt-get update
sudo apt-get install -y mongodb-mongosh