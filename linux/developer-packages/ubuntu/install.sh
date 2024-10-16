## General packages
apt install -y unzip
apt install -y curl
apt install -y vim
apt install -y pv # View process for MySQL restore database
apt install -y strace
apt install -y file
apt install -y htop


# Network
apt install -y dnsutils
apt install -y net-tools
apt install -y iputils-ping
apt install -y telnet

# Disk
apt install -y sysstat
apt install -y iotop

curl -sL https://aka.ms/InstallAzureCLIDeb | bash # az-cli


## Tools
apt install -y exiftool #Read metadata file
apt install -y ibus-unikey # # Type Vietnamese character
apt install -y git
apt install -y youtube-dl # Youtube downloader (video)
apt install -y bless #  Editor for bin files
apt install -y diodon # Save clipboard history
apt install -y neofetch # Show system in4 (pretty)
apt install -y htop # show process (pretty)
apt install -y tree
apt install -y lshw # Display hardware info
apt install -y tilix # Add multi-terminal in 1 display
apt install -y ranger # Advanced File Manager UI for terminal

# Database
apt install -y mysql-client

# Container, Docker & Kubernetes
## Node Shell
curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
chmod +x ./kubectl-node_shell
sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell