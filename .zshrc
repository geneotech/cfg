stty -ixon
# Path to your oh-my-zsh installation.
export ZSH=/home/pbc/.oh-my-zsh
ZSH_THEME="simple"

plugins=(
  extract
)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
. /home/pbc/cfg/shared.sh
# export PS1="%d>"

