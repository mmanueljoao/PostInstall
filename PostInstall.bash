#!/bin/bash

# Initializing
script ./output.log
clear
echo -e "Just a few parameters before we proceed.\n"
printf 'Enter your Username: '
read -r USERNAME
HOME="/home/$USERNAME"
LOGFILE="./logfile"
touch $LOGFILE

select-editor
echo

# ensure that OS is updated
echo "Updating System..."
sudo apt update && sudo apt list --upgradable && sudo apt -y full-upgrade && sudo apt -y autoremove && sudo apt -y autoclean && echo "Update Complete"

# add repositories

# apt install
echo
printf "Installing vim, cargo, curl, git, net-tools and lynx... "
sudo apt install -y vim cargo curl git net-tools lynx && echo "Completed"
echo

printf "Changing git config --global user values... "
git config --global init.defaultBranch main
git config --global user.email "geral@mjoaolima.eu"
git config --global user.name "mmanueljoao" && echo "Completed"

# LAMP Install
echo
printf "Installing Apache2 ... "
sudo apt install -y apache2 && echo "Completed"
apache2 -v
echo

printf "Installing MySQL ... "
sudo apt install -y mysql-server && echo "Completed"
mysql -V
echo

printf "Installing PHP ... "
sudo apt install -y php libapache2-mod-php php-mysql && echo "Completed"
php -v
echo "    Installed Modules printed to file - php -m"
touch $HOME/php_installed_modules
php -m >>php_installed_modules
echo

echo "Current IP Address:"
printf "    " && curl ifconfig.me
echo
echo

# Installing ZSH
printf "Installing ZSH ..."
sudo apt install -y zsh && echo " Completed"
printf "Changing User Shell ..."
sudo usermod --shell /bin/zsh $USERNAME && echo " Completed"
printf "Installing OH-MY-ZSH ..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && echo " Completed"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

cp ./zshrc $HOME/.zshrc
echo

# Creating .bash_aliases

echo "One more thing - here is your NEW ~/.bash_aliases"
ALIASES="$HOME/.bash_aliases"

if [ -f "$ALIASES" ]; then
	echo
	printf "    ~/.bash_aliases already exists. Moving to ~/.bash_aliases.bak\n"
	mv $ALIASES $ALIASES.bak
fi
cp ./aliases $ALIASES

echo
echo -e "    Check your new ~/.bash_aliases at $ALIASES.\t"
echo

# Starship - Cross Shell Prompt
echo "Preparing for take-off - https://starship.rs/"
printf "Installing Starship ..."
curl -fsSL https://starship.rs/install.sh | bash -s -- --yes

mkdir -p $HOME/.config
cp ./starship $HOME/.config/starship.toml && echo " Completed"

printf "Rusting core-utils ..."
sudo apt install -y exa bat ripgrep fd-find
cargo install procs && sudo ln -s $HOME/.cargo/bin/procs /usr/local/bin && echo " Completed"

echo "Post Install Script is finished."
