#! /bin/bash

TF_VERSION="1.10.3"

wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip
unzip terraform_${TF_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/terraform
echo "==== CLEAN UP ===="
rm -f terraform_${TF_VERSION}_linux_amd64.zip
rm -f LICENSE.txt