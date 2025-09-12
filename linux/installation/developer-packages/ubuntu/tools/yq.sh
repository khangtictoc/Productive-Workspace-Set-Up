#! /bin/bash

YQ_VERSION=v4.2.0
YQ_BINARY=yq_linux_amd64
wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}.tar.gz -O - |\
    tar xz && mv ${YQ_BINARY} /usr/local/bin/yq