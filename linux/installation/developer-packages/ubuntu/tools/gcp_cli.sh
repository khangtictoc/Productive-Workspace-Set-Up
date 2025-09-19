#! /bin/bash

if ! command -v gcloud 2>&1 >/dev/null
then
    echo "[INSTALLING ⬇️ ] Google Cloud CLI"
    curl https://packages.cloud.google.com/sudo apt/doc/sudo apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/sudo apt cloud-sdk main" | tee -a /etc/sudo apt/sources.list.d/google-cloud-sdk.list
    sudo apt-get update && sudo apt-get install google-cloud-cli
else
    echo "- [CHECKED ✅] gcloud command exists"
fi