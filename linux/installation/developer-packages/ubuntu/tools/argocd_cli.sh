#! /bin/bash

ARGO_CLI_VERSION="v3.0.16"
wget "https://github.com/argoproj/argo-cd/releases/download/${ARGO_CLI_VERSION}/argocd-linux-amd64" -O argocd
sudo chmod +x argocd
sudo mv argocd /usr/local/bin/argocd