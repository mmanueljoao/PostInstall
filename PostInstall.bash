#!/usr/bin/env bash

# Initializing
clear
echo -e "Just a few parameters before we proceed.\n"
printf 'Enter your Username: '
read -r USERNAME
HOME="/home/$USERNAME"

echo

# add repositories
## Official PPA by git
sudo add-apt-repository -y ppa:git-core/ppa

# ensure that OS is updated
echo "Updating System..."
sudo apt update && sudo apt list --upgradable && sudo apt -y full-upgrade && sudo apt -y autoremove && sudo apt -y autoclean && echo "Update Complete"

# apt install
echo
printf "Installing vim, cargo, curl, git, {net,wireless}-tools and ... "
sudo apt install -y vim cargo curl git net-tools wireless-tools && echo "Completed"
echo

printf "Setting WHO AM I for git ... "
git config --global init.defaultBranch main
git config --global user.email "geral@mjoaolima.eu" && git config --global user.name "mmanueljoao" && echo "Completed"

# # LAMP Install
# echo
# printf "Installing Apache2 ... "
# sudo apt install -y apache2 && echo "Completed"
# apache2 -v
# echo

# printf "Installing MySQL ... "
# sudo apt install -y mysql-server && echo "Completed"
# mysql -V
# echo

# printf "Installing PHP ... "
# sudo apt install -y php libapache2-mod-php php-mysql && echo "Completed"
# php -v
# echo "    Installed Modules printed to file - php -m"
# touch $HOME/php_installed_modules
# php -m >>php_installed_modules
# echo

# echo "Current IP Address:"
# printf "    " && curl ifconfig.me
# echo
echo

printf "Setting up your config files... "
## This DELETES ALL FILES in HOME
rm -rf $HOME/{*,.*}

git clone --bare https://github.com/mmanueljoao/.dotfiles.git $HOME/.dotfiles
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout 
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push --set-upstream origin main&& echo "Completed"

# Installing ZSH
printf "Installing ZSH ..."
sudo apt install -y zsh && echo " Completed"
printf "Changing User Shell ..."
sudo usermod --shell /bin/zsh $USERNAME && echo " Completed"
printf "Installing OH-MY-ZSH ..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && echo " Completed"

git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

## Instalation of zsh WITH oh-my-zsh moves files from the *dotfiles* repo. This is a necessary corrections.
mv .zshrc.pre-oh-my-zsh .zshrc
echo

# Starship - Cross Shell Prompt
echo "Preparing for take-off - https://starship.rs/"
printf "Installing Starship ..."
curl -fsSL https://starship.rs/install.sh | bash -s -- --yes

mkdir -p $HOME/.config
# cp ./starship $HOME/.config/starship.toml && 
echo " Completed"

printf "Rusting core-utils ..."
sudo apt install -y exa bat ripgrep fd-find && echo " Completed"


echo "Post Install Script is finished."
