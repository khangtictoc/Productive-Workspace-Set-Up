## ENVIRONMENT VARIABLES ##
HELM_VERSION=v3.16.4
RUBY_VERSION=3.4.4
ZSHRC_FILE="$HOME/.zshrc"

# ┌──────────────────────────────────────┐
# │                                      │
# │    Prerequisites/Must-have Tools     │
# │                                      │
# └──────────────────────────────────────┘
sudo apt install -y unzip
sudo apt install -y python3-pip

# WSL
## Install WSL utilities - Open links in host browser, copy/paste between WSL and Windows, etc.
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install -y wslu

# File Editor
sudo apt install -y vim
sudo apt install -y nano
# Superfile - File Manager
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"


# Download URL
sudo apt install -y wget
sudo apt install -y curl
sudo apt install -y dos2unix


# Network
sudo apt install -y dnsutils
sudo apt install -y net-tools
sudo apt install -y iputils-ping
sudo apt install -y telnet
sudo apt install -y inetutils-traceroute
sudo apt install -y nmap
sudo apt install -y netcat
sudo apt install -y whois
sudo apt install -y mtr
curl -sS https://raw.githubusercontent.com/mr-karan/doggo/main/install.sh | sh
# ngrok
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
  | sudo tee /etc/apt/sources.list.d/ngrok.list \
  && sudo apt update \
  && sudo apt install ngrok

# Disk
sudo apt install -y sysstat
sudo apt install -y iotop
sudo apt install -y ncdu # Treesizeview in Linux

# ┌────────────────────────────┐
# │                            │
# │      Productive Tools      │
# │                            │
# └────────────────────────────┘
sudo apt install -y exiftool #Read metadata file
sudo apt install -y ibus-unikey # # Type Vietnamese character
sudo apt install -y git
sudo apt install -y youtube-dl # Youtube downloader (video)
sudo apt install -y bless #  Editor for bin files
sudo apt install -y diodon # Save clipboard history
sudo apt install -y neofetch # Show system in4 (pretty)
sudo apt install -y htop # show process (pretty)
sudo apt install -y tree
sudo apt install -y lshw # Display hardware info
sudo apt install -y tilix # Add multi-terminal in 1 display
sudo apt install -y ripgrep # ripgrep - Search content in multiples files or folders
sudo apt install -y bc # Convenient calculator
sudo apt install -y jq # JSON Values Extractor
# YAML Values Extractor
YQ_VERSION=v4.2.0
YQ_BINARY=yq_linux_amd64
wget https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}.tar.gz -O - |\
  tar xz && mv ${BINARY} /usr/local/bin/yq
sudo apt install -y chrony # NTP Client
npm install -g @jsware/jsonpath-cli # JSONPath query tool
sudo apt-get purge lolcat -y
gem install lolcat # Require Ruby

# ┌──────────────────────────────────────┐
# │                                      │
# │    Terminal, Linux system and TUI    │
# │                                      │
# └──────────────────────────────────────┘

## Monitoring
sudo apt install -y iftop
sudo apt install -y iotop
sudo apt install -y atop
## sysz (Systemd service manager)
wget -O /usr/local/bin/sysz https://github.com/joehillen/sysz/releases/latest/download/sysz
sudo chmod +x /usr/local/bin/sysz

# Network
wget https://github.com/imsnif/bandwhich/releases/download/v0.23.1/bandwhich-v0.23.1-x86_64-unknown-linux-gnu.tar.gz
tar -xzf bandwhich-v0.23.1-x86_64-unknown-linux-gnu.tar.gz
sudo cp bandwhich /usr/local/bin/bandwhich
echo "==== CLEAN UP ===="
rm -f bandwhich-v0.23.1-x86_64-unknown-linux-gnu.tar.gz bandwhich

# Kernal Modules
wget https://github.com/orhun/kmon/releases/download/v1.7.1/kmon-1.7.1-x86_64-unknown-linux-gnu.tar.gz
tar -xzf kmon-1.7.1-x86_64-unknown-linux-gnu.tar.gz
sudo cp kmon-1.7.1/kmon /usr/local/bin/kmon
echo "==== CLEAN UP ===="
rm -f kmon-1.7.1-x86_64-unknown-linux-gnu.tar.gz
rm -drf kmon-1.7.1

# GPU
sudo add-apt-repository ppa:quentiumyt/nvtop
sudo apt install nvtop

# UFW
wget https://github.com/peltho/tufw/releases/download/v0.2.4/tufw_0.2.4_linux_amd64.deb
sudo dpkg -i tufw_0.2.4_linux_amd64.deb
echo "==== CLEAN UP ===="
rm -f tufw_0.2.4_linux_amd64.deb

# System's processes
sudo apt install -y pv # View process for MySQL restore database
sudo apt install -y strace
sudo apt install -y file
sudo apt install -y htop


# ┌────────────────────────────┐
# │                            │
# │       Cloud Platform       │
# │                            │
# └────────────────────────────┘
## AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
echo "==== CLEAN UP ===="
rm -f awscliv2.zip && rm -drf aws

## Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash 

## GCP
curl https://packages.cloud.google.com/sudo apt/doc/sudo apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/sudo apt cloud-sdk main" | tee -a /etc/sudo apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli


# ┌────────────────────────────┐
# │                            │
# │   Programming Languages    │
# │                            │
# └────────────────────────────┘

## Ruby - Using rbenv. Reference: https://github.com/rbenv/rbenv?tab=readme-ov-file#basic-github-checkout
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
~/.rbenv/bin/rbenv init
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
git -C "$(rbenv root)"/plugins/ruby-build pull
sudo apt-get install build-essential autoconf libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc
rbenv install ${RUBY_VERSION:-3.4.4} # Install Ruby version

## NodeJS
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
# Download and install Node.js:
nvm install 22
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.24.5.linux-amd64.tar.gz

## Go/Golang
wget "https://go.dev/dl/go1.24.5.linux-amd64.tar.gz"
tar xfvz go1.24.5.linux-amd64.tar.gz
cp go/bin/* /usr/local/bin/
echo "==== CLEAN UP ===="
rm -drf go1.24.5.linux-amd64.tar.gz go

# Blogging Jekyll
gem install bundler
bundle install
bundle exec jekyll serve

# Database Tools
## MySQL
sudo apt install -y mysql-client
## Redis
sudo apt install -y nodejs
sudo apt install -y npm
npm install -g redis-cli
## SQL Server
curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
source /etc/os-release
curl https://packages.microsoft.com/config/ubuntu/$VERSION_ID/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
sudo apt-get update
sudo apt-get install mssql-tools18 unixodbc-dev -y
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile
source ~/.bash_profile
## Postgres
sudo apt install -y postgresql-client # Already include pgdump, pg_restore, psql, etc.
## MongoDB
### Tools
wget "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb"       
dpkg -i mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb
echo "==== CLEAN UP ===="
rm -f mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb
### MongoDB Shell
wget -qO- https://www.mongodb.org/static/pgp/server-8.0.asc |  tee /etc/sudo apt/trusted.gpg.d/server-8.0.asc
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/sudo apt/ubuntu noble/mongodb-org/8.0 multiverse" | tee /etc/sudo apt/sources.list.d/mongodb-org-8.0.list
sudo apt-get update
sudo apt-get install -y mongodb-mongosh

# ┌────────────────────────────┐
# │                            │
# │      DevOps Tools          │
# │                            │
# └────────────────────────────┘

# ---- CONTAINER ----
## Docker
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/sudo apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/sudo apt/keyrings/docker.asc
sudo chmod a+r /etc/sudo apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/sudo apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  tee /etc/sudo apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
docker run hello-world

## Dive - Compare Docker image's difference
DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -OL https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb
sudo apt install ./dive_${DIVE_VERSION}_linux_amd64.deb
echo "==== CLEAN UP ===="
rm -f dive_${DIVE_VERSION}_linux_amd64.deb

## Kubectl - Kubernetes CLI
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

#  kubectl krew - Plugin manager for kubectl
set -x; cd "$(mktemp -d)" &&
OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
KREW="krew-${OS}_${ARCH}" &&
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
tar zxvf "${KREW}.tar.gz" &&
./"${KREW}" install krew


EXPORT_KREW_PATH='export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"'
if grep -Fxq "$EXPORT_KREW_PATH" "$ZSHRC_FILE"; then
  echo "✅ Krew binary has been added to PATH! No changes"
else
  echo "$EXPORT_KREW_PATH" >> "$ZSHRC_FILE"
  echo "✅ Krew binary has been added to PATH\!"
fi

#  kubectl krew - Install useful plugins
kubectl krew install tree
kubectl krew install view-secret

# Kubectl Node Shell
curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
sudo chmod +x ./kubectl-node_shell
sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell

## K9S
wget https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb
sudo apt install ./k9s_linux_amd64.deb
echo "==== CLEAN UP ===="
rm k9s_linux_amd64.deb

## Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

## Helm
curl -O https://get.helm.sh/helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz
tar -zxvf helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
echo "==== CLEAN UP ===="
rm -f helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz

## Kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

## Argo CLI
ARGO_CLI_VERSION="v3.0.16"
wget "https://github.com/argoproj/argo-cd/releases/download/${ARGO_CLI_VERSION}/argocd-linux-amd64" -O argocd
sudo chmod +x argocd
sudo mv argocd /usr/local/bin/argocd

# ---- INFRA-AS-CODE (IAC) ----
## Terraform
wget https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_amd64.zip
unzip terraform_1.10.3_linux_amd64.zip
sudo mv terraform /usr/local/bin/terraform
echo "==== CLEAN UP ===="
rm -f terraform_1.10.3_linux_amd64.zip

## Terragrunt
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.71.2-alpha2024122002/terragrunt_linux_amd64
sudo chmod u+x terragrunt_linux_amd64
sudo mv terragrunt_linux_amd64 /usr/local/bin/terragrunt

## Packer
curl -fsSL https://sudo apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://sudo apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install packer

## Vagrant
wget -O - https://sudo apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://sudo apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/sudo apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant
vagrant plugin install vagrant-vmware-desktop # Optional

# ---- GIT ----
## git filter-repo 
wget -O git-filter-repo https://raw.githubusercontent.com/newren/git-filter-repo/main/git-filter-repo
sudo chmod +x git-filter-repo
sudo mv git-filter-repo /usr/local/bin/
## glab
wget -O glab_1.67.0_linux_amd64.deb https://gitlab.com/gitlab-org/cli/-/releases/v1.67.0/downloads/glab_1.67.0_linux_amd64.deb
sudo dpkg -i glab_1.67.0_linux_amd64.deb
echo "==== CLEAN UP ===="
rm glab_1.67.0_linux_amd64.deb

# ---- SECRET MANAGER ----
## HCP Vault
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault

# ---- TLS/SSL ----
## Certbot(Let's Encrypt)
sudo apt install -y certbot python3-certbot-nginx


# ┌────────────────────────────┐
# │                            │
# │       Security Tools       │
# │                            │
# └────────────────────────────┘

# ---- SCAN SECRETS ----

## GGShield
pip install --user ggshield
pip install --user --upgrade ggshield

## TruffleHog
curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sudo sh -s -- -b /usr/local/bin

## detect-secrets
echo "==== INSTALLING DETECT SECRETS ===="
wget "https://codeload.github.com/Yelp/detect-secrets/zip/refs/tags/v1.5.0" -O detect-secrets.zip
unzip detect-secrets.zip
cd detect-secrets-1.5.0
python3 setup.py install
cd .. && rm -rf detect-secrets-1.5.0 detect-secrets.zip
echo "==== CLEAN UP ===="

# ---- VULNERABILITY SCANNER ----

## Grype - Work with Syft (SBOM tool)
curl -sSfL https://get.anchore.io/grype | sudo sh -s -- -b /usr/local/bin

# ┌────────────────────────────┐
# │                            │
# │     Software Billings      │
# │                            │
# └────────────────────────────┘

# ---- SBOM TOOLS ----
## Syft
curl -sSfL https://get.anchore.io/syft | sudo sh -s -- -b /usr/local/bin

