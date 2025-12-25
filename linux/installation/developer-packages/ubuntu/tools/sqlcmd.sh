#! /bin/bash

source /etc/os-release
CURRENT_SHELL=$(basename "$SHELL")
SHELL_SOURCE="$HOME/.${CURRENT_SHELL}rc"

if ! command -v sqlcmd 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] SQL Server Command Line Tools"
    curl  https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
    curl  https://packages.microsoft.com/config/ubuntu/$VERSION_ID/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
    
    sudo apt-get update
    sudo apt-get install -y \
    mssql-tools18 \
    unixodbc-dev

    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> "$SHELL_SOURCE"
    source "$SHELL_SOURCE"

    if ! command -v sqlcmd &> /dev/null; then
        echo "[FAIL ❌] sqlcmd installation failed!"
        exit 1
    fi
    
    echo "[CHECKED ✅] sqlcmd command installed!"
else
    echo "[CHECKED ✅] sqlcmd command exists"
fi