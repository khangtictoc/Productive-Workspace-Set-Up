#! /bin/bash

if ! command -v vagrant 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Vagrant"
    wget --progress=dot:giga \
        -O - https://sudo apt.releases.hashicorp.com/gpg \
        | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://sudo apt.releases.hashicorp.com $(lsb_release -cs) main" \
        | tee /etc/sudo apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install vagrant
    vagrant plugin install vagrant-vmware-desktop # Optional
    echo "- [CHECKED ✅] vagrant command installed!"
else
    echo "- [CHECKED ✅] vagrant command exists"
fi