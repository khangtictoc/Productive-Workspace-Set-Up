#! /bin/bash

if ! command -v git-filter-repo 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] git-filter-repo"
    wget -O git-filter-repo https://raw.githubusercontent.com/newren/git-filter-repo/main/git-filter-repo
    sudo chmod +x git-filter-repo
    sudo mv git-filter-repo /usr/local/bin/
else
    echo "- [CHECKED ✅] git-filter-repo command exists"
fi