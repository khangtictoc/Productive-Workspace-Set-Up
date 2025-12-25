#! /bin/bash

if ! command -v vagrant 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Vagrant"
    wget --progress=dot:giga \
        -O - https://apt.releases.hashicorp.com/gpg \
        | gpg --yes --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
        | tee /etc/apt/sources.list.d/hashicorp.list
    
    sudo apt update && sudo apt install -y vagrant

    read -p "Do you want to install Vagrant Plugins (VMware Provider on Window for examples)? (y/n): "
    if [[ "$CONFIRM" == "y" || "$CONFIRM" == "Y" ]]; then
        vagrant plugin install vagrant-vmware-desktop # Optional
        echo "[CHECKED ✅] vagrant plugins command installed!"
    else
        echo "[INFO] Installation aborted by user."
        exit 1
    fi
    
    echo "[CHECKED ✅] vagrant command installed!"
else
    echo "[CHECKED ✅] vagrant command exists"
fi