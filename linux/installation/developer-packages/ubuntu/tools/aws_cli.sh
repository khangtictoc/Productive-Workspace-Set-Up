#! /bin/bash

ARCH=$(uname -m)

if ! command -v aws 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] AWS CLI   "
    if [ "$ARCH" = "aarch64" ]; then
        curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        echo "==== CLEAN UP ===="
        rm -f awscliv2.zip && rm -drf aws
        echo "- [CHECKED ✅] aws command installed!"
    fi
    if [ "$ARCH" = "x86_64" ]; then
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        echo "==== CLEAN UP ===="
        rm -f awscliv2.zip && rm -drf aws
        echo "- [CHECKED ✅] aws command installed!"
    fi
else
    echo "- [CHECKED ✅] aws command exists!"
    exit 0
fi
