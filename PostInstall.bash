#!/bin/bash

# Initializing
clear
echo -e "Just a few parameters before we proceed.\n"
printf 'Enter your Username: '
read -r USERNAME
HOME="/home/$USERNAME/"

select-editor

# ensure that OS is updated
echo "Updating System..."
sudo apt update &>/dev/null && sudo apt list --upgradable && sudo apt -y full-upgrade &>/dev/null && sudo apt -y autoremove &>/dev/null && sudo apt -y autoclean &>/dev/null && echo "Update Complete"

# add repositories

# apt install
printf "Installing needed packages... "
sudo apt install -y vim curl git &>/dev/null

git config --global init.defaultBranch main
git config --global user.email "geral@mjoaolima.eu"
git config --global user.name "mmanueljoao" && echo "Completed"

echo
printf "Installing net-tools, vim and lynx ... "
sudo apt install -y net-tools vim lynx &>/dev/null && echo "Completed"

# LAMP Install
echo
printf "Installing Apache2 ... "
sudo apt install -y apache2 &>/dev/null && echo "Completed"
apache2 -v
echo

printf "Installing MySQL ... "
sudo apt install -y mysql-server &>/dev/null && echo "Completed"
mysql -V
echo

printf "Installing PHP ... "
sudo apt install -y php libapache2-mod-php php-mysql &>/dev/null && echo "Completed"
php -v
echo "    Installed Modules printed to file - php -m"
touch $HOME/php_installed_modules
php -m >>php_installed_modules
echo

echo "Current IP Address:"
printf "    " && curl ifconfig.me
echo

# Installing ZSH
printf "Installing ZSH ..."
sudo apt install -y zsh &>/dev/null && echo " Completed"
printf "Changing User Shell ..."
usermod --shell /bin/zsh $USERNAME &>/dev/null && echo " Completed"
printf "Installing OH-MY-ZSH ..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &>/dev/null && echo " Completed"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions &>/dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &>/dev/null

echo ./zshrc >$HOME/.zshrc
echo

# Creating .aliases

echo "One more thing - here is your NEW ~/.aliases"
ALIASES="$HOME/.aliases"

echo
if [ -f "$ALIASES" ]; then
	printf "    ~/.aliases already exists. Moving to ~/.aliases.bak\n"
	mv $ALIASES $ALIASES.bak
fi

touch $ALIASES
echo
echo ./aliases >$ALIASES
source $ALIASES
echo -e "    Check your new ~/.aliases at $ALIASES.\t"
echo

# Starship - Cross Shell Prompt
echo "Preparing for take-off - https://starship.rs/"
printf "Installing Starship ..."
curl -fsSL https://starship.rs/install.sh | bash &>/dev/null

mkdir -m $HOME/.config &
echo ./starship >$HOME/.config/starship.toml && echo " Completed"

printf "De-Rusting utilities ..."
sudo apt install -y cargo exa bat ripgrep fd-find &>/dev/null
cargo install procs && ln -s $HOME/.cargo/bin/procs /usr/local/bin && echo " Completed"

echo "Post Install Script is finished."
