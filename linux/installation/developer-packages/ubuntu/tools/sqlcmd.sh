#! /bin/bash

if ! command -v sqlcmd 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] SQL Server Command Line Tools"
    curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
    source /etc/os-release
    curl https://packages.microsoft.com/config/ubuntu/$VERSION_ID/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
    sudo apt-get update
    sudo apt-get install mssql-tools18 unixodbc-dev -y
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile
    source ~/.bash_profile
    echo "- [CHECKED ✅] sqlcmd command installed!"
else
    echo "- [CHECKED ✅] sqlcmd command exists"
fi