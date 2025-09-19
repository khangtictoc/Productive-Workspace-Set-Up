#! /bin/bash

if ! command -v packer 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Packer"
    curl -fsSL https://sudo apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://sudo apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install packer
else
    echo "- [CHECKED ✅] packer command exists"
fi