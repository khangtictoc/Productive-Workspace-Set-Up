#! /bin/bash

GO_VERSION=1.24.5
wget "https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz"
tar xfvz go$GO_VERSION.linux-amd64.tar.gz
cp go/bin/* /usr/local/bin/
echo "==== CLEAN UP ===="
rm -drf go$GO_VERSION.linux-amd64.tar.gz go