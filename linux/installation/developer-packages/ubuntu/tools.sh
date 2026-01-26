# References
# - Generating text box: https://lurki.com/text-operations/text-box-generator

## ENVIRONMENT VARIABLES ##

SHELLRC_FILE="$HOME/.zshrc"

# ┌──────────────────────────────────────┐
# │                                      │
# │    Prerequisites/Must-have Tools     │
# │                                      │
# └──────────────────────────────────────┘

sudo apt install -y unzip
sudo apt install -y python3-pip
sudo apt install -y linux-tools-generic # 'perf' command
sudo apt install -y tree
sudo apt install -y jq # JSON Values Extractor
sudo apt install -y chrony # NTP Client
sudo apt install -y wget
sudo apt install -y curl
sudo apt install -y dos2unix
sudo apt install -y file


# --- WSL ---
## Install WSL utilities - Open links in host browser, copy/paste between WSL and Windows, etc.
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install -y wslu

# --- FILE ---
sudo apt install -y vim
sudo apt install -y nano

## Superfile - File Manager
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"

## ls_extended - Extended 'ls' command
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/ls_extended.sh | sudo bash

# --- NETWORK ---
sudo apt install -y dnsutils
sudo apt install -y net-tools
sudo apt install -y iputils-ping
sudo apt install -y telnet
sudo apt install -y inetutils-traceroute
sudo apt install -y nmap
sudo apt install -y netcat
sudo apt install -y whois
sudo apt install -y mtr
curl -sS https://raw.githubusercontent.com/mr-karan/doggo/main/install.sh | bash
## ngrok
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/ngrok.sh | bash

# --- DISK ---
sudo apt install -y sysstat
sudo apt install -y iotop
sudo apt install -y ncdu # 'du' TUI, Treesizeview in Linux

# ┌────────────────────────────┐
# │                            │
# │      Productive Tools      │
# │                            │
# └────────────────────────────┘

sudo apt install -y exiftool # Read file's metadata
sudo apt install -y ibus-unikey # Type 'Vietnamese' character
sudo apt install -y git # Git version control
sudo apt install -y youtube-dl # Youtube downloader
sudo apt install -y bless #  Bin files editor
sudo apt install -y diodon # Save clipboard history
sudo apt install -y neofetch # Show system info (pretty)
sudo apt install -y lshw # Display hardware info
sudo apt install -y tilix # Add multi-terminal in 1 display
sudo apt install -y ripgrep # ripgrep - Search content in multiples files or folders
sudo apt install -y bc # Convenient calculator
sudo apt-get purge lolcat -y
gem install lolcat # Require Ruby
npm install -g @jsware/jsonpath-cli # JSONPath query tool
sudo apt install -y faker # Generate fake data (username, email, address, etc.)

# YAML Values Extractor
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/yq.sh | sudo bash

# jtbl - JSON Table
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/jtbl.sh | sudo bash

# ANSI Color
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/ansi_color.sh | sudo bash

# ┌──────────────────────────────────────┐
# │                                      │
# │        TUI & Performance Tools       │
# │                                      │
# └──────────────────────────────────────┘

# --- MONITOR ---
sudo apt install -y iftop
sudo apt install -y iotop
sudo apt install -y atop
## sysz (Systemd service manager)
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/sysz.sh | bash

# --- NETWORK ---

## bandwhich
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/bandwhich.sh | bash

## speedtest - Ping latency
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest

# --- KERNEL MANAGEMENT ---
## kmon # View kernel's modules
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/kmon.sh | bash

# GPU
## nvtop - NVIDIA GPU process monitor
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/nvtop.sh | bash

# UFW
## tufw - TUI for UFW
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/tufw.sh | bash

# --- SYSTEM PROCESSES/LINUX SYSCALL ---
sudo apt install -y pv # i.e View process for MySQL restore database
sudo apt install -y strace
sudo apt install -y htop



# ┌────────────────────────────┐
# │                            │
# │       Cloud Platform       │
# │                            │
# └────────────────────────────┘

# --- AWS ---

## AWS CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/aws_cli.sh | bash

## Stu - S3 Explorer TUI
cargo install --locked stu

## AWS Cost Explorer CLI
npm install -g aws-cost-cli

## AWS FinOps Dashboard
pip install aws-finops-dashboard

# --- Azure CLI ---
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/az_cli.sh | bash

# --- GCP ---
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/gcp_cli.sh | bash


# ┌────────────────────────────┐
# │                            │
# │   Programming Languages    │
# │                            │
# └────────────────────────────┘

## Ruby
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/ruby.sh | bash

## Rust (+ Cargo)
curl https://sh.rustup.rs -sSf | bash

## NodeJS + NPM
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/nodejs.sh | bash

## Go/Golang
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/go.sh | bash

## UV - Light-weight Python Package Manager
curl -LsSf https://astral.sh/uv/install.sh | sh

# Blogging Jekyll
gem install bundler
bundle install
# bundle exec jekyll serve

# ┌──────────────────┐
# │                  │
# │  Database Tools  │
# │                  │
# └──────────────────┘

## MySQL
sudo apt install -y mysql-client

## Redis
npm install -g redis-cli

## SQL Server (MSSQL) CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/sqlcmd.sh | bash

## Postgres
sudo apt install -y postgresql-client # Already include pgdump, pg_restore, psql, etc.

## MongoDB
### Tools & Shell
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/mongodb_cli.sh | bash

# ┌────────────────────────────┐
# │                            │
# │      DevOps Tools          │
# │                            │
# └────────────────────────────┘

# ---- CONTAINER ----
## Docker
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/docker.sh | bash

## Dive - Compare Docker image's difference
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/dive.sh | bash

## Trivy - Scan Docker image vulnerabilities (Other: Scan SBOM, Filesystem, Git Repo, ...)
curl -sSfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo bash -s -- -b /usr/local/bin

## Kubectl - Kubernetes CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/kubectl.sh | bash

## Kube-linter
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/kube_linter.sh | bash

## Kubesec
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/kubesec.sh | bash

## K9S
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/k9s.sh | bash

## Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

## Helm
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/helm.sh | bash

## Kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

## Argo CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/argocd_cli.sh | bash

# ---- INFRA-AS-CODE (IAC) ----
## Terraform
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/terraform.sh | bash
## Terraform Visual (visualize TF dependency graph)
npm install -g @terraform-visual/cli
## Blast Radius (visualize TF dependency graph)
pip install blastradius

## Terragrunt
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/terragrunt.sh | bash

## Packer
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/packer.sh | bash

## Vagrant & Plugins
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/vagrant.sh | bash

# ---- GIT ----

## git filter-repo 
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/git_filter_repo.sh | bash

## glab - GitLab CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/glab.sh | bash

# ---- SECRET MANAGER ----
## HCP Vault
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/hcp_vault.sh | bash

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
curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sudo bash -s -- -b /usr/local/bin

## detect-secrets
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/detect_secrets.sh | bash

# ---- VULNERABILITY SCANNER ----

## Grype - Scan SBOM (Work with Syft)
curl -sSfL https://get.anchore.io/grype | sudo bash -s -- -b /usr/local/bin

# ┌────────────────────────────┐
# │                            │
# │     Software Billings      │
# │                            │
# └────────────────────────────┘

# ---- SBOM TOOLS ----
## Syft (SBOM Generator)
curl -sSfL https://get.anchore.io/syft | sudo bash -s -- -b /usr/local/bin


# ┌───────────────────────┐
# │                       │
# │  AI Generative Tools  │
# │                       │
# └───────────────────────┘

# ---- CHATBOT ----

## Google Gemini
npm install -g @google/gemini-cli

## Claude
curl -fsSL https://claude.ai/install.sh | bash

# --- LLM ---
## Ollama
curl -fsSL https://ollama.com/install.sh | sh