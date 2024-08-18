sudo apt install -y unzip
curl -s https://ohmyposh.dev/install.sh | bash -s

# To list all available fonts
# oh-my-posh font install
# oh-my-posh font install <font-name>

oh-my-posh init fish --config /home/virus/.cache/oh-my-posh/themes/cloud-native-azure.omp.json > ~/.oh-my-posh-init && source ~/.oh-my-posh-init
echo -n "[ -f ~/.oh-my-posh-init ] && source ~/.oh-my-posh-init" | tee -a ~/.config/fish/config.fish