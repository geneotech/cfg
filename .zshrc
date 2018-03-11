stty -ixon
# Path to your oh-my-zsh installation.
export ZSH=/home/pbc/.oh-my-zsh
ZSH_THEME="simple"

plugins=(
  extract
)

. $ZSH/oh-my-zsh.sh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/pbc/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
. /home/pbc/cfg/shell/interactive.sh
# export PS1="%d>"

