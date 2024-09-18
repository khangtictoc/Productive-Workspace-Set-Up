sudo apt install -y unzip
curl -s https://ohmyposh.dev/install.sh | bash -s

#### To list all available fonts
# oh-my-posh font install
# oh-my-posh font install <font-name>

#### On WSL
# sudo cp ~/.local/bin/oh-my-posh /usr/local/bin/

set THEME "cloud-native-azure"
set APPLIED_SHELL "fish"
oh-my-posh init $APPLIED_SHELL --config ~/.cache/oh-my-posh/themes/$THEME.omp.json > ~/.oh-my-posh-init && source ~/.oh-my-posh-init
echo -n "[ -f ~/.oh-my-posh-init ] && source ~/.oh-my-posh-init" | tee -a ~/.config/fish/config.fish