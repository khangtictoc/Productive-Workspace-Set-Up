#! /bin/bash


## START ## 
sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Programming Languages & Frameworks
brew install node
brew install git-lfs
brew install unzip
brew install python3

brew install tmux

# General
brew install unzip

# File Editor
brew install vim
brew install nano

# System's health & process
brew install pv # View process for MySQL restore database
brew install file
brew install htop
brew install wget
brew install curl
brew install dos2unix

# Network
brew install bind # Provides `dig` (dnsutils equivalent)
#brew install telnet
brew install inetutils # Includes traceroute, telnet
brew install nmap
brew install netcat
brew install whois
brew install mtr
brew install doggo # DNS lookup tool

## Monitoring
brew install iftop


# Azure CLI
brew install azure-cli

# Tools
brew install exiftool # Read metadata file
brew install git
brew install neofetch # Show system info (pretty)
brew install tree
brew install ripgrep # Search content in multiple files or folders
brew install bc # Convenient calculator
brew install jq # JSON values extractor

# Database Clients
## MySQL
brew install mysql-client
echo 'export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"' >> ~.zshrc
export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"
## Redis
brew install node
npm install -g redis-cli

## Postgres
brew install postgresql

# Container Environment
## Docker
## > INSTALL BY DOCKER DESKTOP

## Dive - Compare Docker image's difference
brew install dive

## Kubectl - Kubernetes CLI
brew install kubectl

## Node Shell
curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
chmod +x ./kubectl-node_shell
sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell

## K9S
brew install k9s

# Lazydocker
brew install lazydocker

# Helm
brew install helm

# AWS CLI
brew install awscli

# VM images, Infrastructure & Configuration templating
## Terraform
brew install terraform

## Terragrunt
brew install terragrunt

## Packer
brew tap hashicorp/tap
brew install hashicorp/tap/packer
brew upgrade hashicorp/tap/packer

## Vagrant
brew tap hashicorp/tap
brew install hashicorp/tap/vagrant
brew upgrade hashicorp/tap/vagrant
vagrant plugin install vagrant-vmware-desktop # Optional
