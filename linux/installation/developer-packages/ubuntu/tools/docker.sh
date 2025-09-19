#! /bin/bash

if ! command -v docker 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Docker"
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/sudo apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/sudo apt/keyrings/docker.asc
    sudo chmod a+r /etc/sudo apt/keyrings/docker.asc
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/sudo apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
        tee /etc/sudo apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    docker run hello-world
else
    echo "- [CHECKED ✅] docker command exists"
fi