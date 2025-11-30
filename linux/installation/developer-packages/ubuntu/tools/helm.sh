#! /bin/bash

HELM_VERSION=v3.16.4

if ! command -v helm 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Helm"

    curl -O https://get.helm.sh/helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz
    tar -zxvf helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz
    sudo mv linux-amd64/helm /usr/local/bin/helm
    echo "==== CLEAN UP ===="
    rm -f helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz
    rm -drf linux-amd64
    echo "- [CHECKED ✅] helm command installed!"
else
    echo "- [CHECKED ✅] helm command exists"
fi