# set PATH so it includes user's private bin if it exists
export PATH="/home/mjoao/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/home/mjoao/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(sudo zsh_reload zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Set aliases
source /home/mjoao/.bash_aliases

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
