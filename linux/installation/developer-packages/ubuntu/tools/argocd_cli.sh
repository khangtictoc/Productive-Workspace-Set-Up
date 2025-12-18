#! /bin/bash

ARGO_CLI_VERSION="v3.0.16"

if ! command -v argocd 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] ArgoCD CLI"
      "https://github.com/argoproj/argo-cd/releases/download/${ARGO_CLI_VERSION}/argocd-linux-amd64" -O argocd
    sudo chmod +x argocd
    sudo mv argocd /usr/local/bin/argocd

    if ! command -v argocd &> /dev/null; then
        echo "[FAIL ❌] argocd installation failed!"
        exit 1
    fi

    echo "- [CHECKED ✅] argocd command installed!"
else
    echo "- [CHECKED ✅] argocd command exists"
fi