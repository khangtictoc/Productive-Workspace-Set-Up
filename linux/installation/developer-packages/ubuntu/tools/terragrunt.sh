#! /bin/bash

TFG_VERSION="0.71.2-alpha2024122002"

if ! command -v terragrunt 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Terragrunt"
    wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TFG_VERSION}/terragrunt_linux_amd64
    sudo chmod u+x terragrunt_linux_amd64
    sudo mv terragrunt_linux_amd64 /usr/local/bin/terragrunt
else
    echo "- [CHECKED ✅] terragrunt command exists"
fi

