#! /bin/bash

if ! command -v nvtop 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] nvtop"
    sudo add-apt-repository ppa:quentiumyt/nvtop
    sudo apt update
    sudo apt install -y nvtop
    echo "- [CHECKED ✅] nvtop command installed!"
else
    echo "- [CHECKED ✅] nvtop command exists"
fi