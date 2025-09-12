#! /bin/bash

ARCH=$(uname -m)

if [ "$ARCH" = "aarch64" ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    echo "==== CLEAN UP ===="
    rm -f awscliv2.zip && rm -drf aws
fi

if [ "$ARCH" = "x86_64" ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    echo "==== CLEAN UP ===="
    rm -f awscliv2.zip && rm -drf aws
fi