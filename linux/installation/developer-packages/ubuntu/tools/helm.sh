#! /bin/bash

HELM_VERSION=v3.16.4

curl -O https://get.helm.sh/helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz
tar -zxvf helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
echo "==== CLEAN UP ===="
rm -f helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz