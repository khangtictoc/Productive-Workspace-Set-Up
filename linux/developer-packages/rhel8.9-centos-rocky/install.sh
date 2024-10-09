#! /bin/bash

rpm --import https://packages.microsoft.com/keys/microsoft.asc
dnf install -y https://packages.microsoft.com/config/rhel/9.0/packages-microsoft-prod.rpm
dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
dnf install azure-cli