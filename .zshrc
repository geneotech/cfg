stty -ixon

export ZSH=$HOME/.oh-my-zsh
. $ZSH/oh-my-zsh.sh

. ~/cfg/sh/interactive/fzf-key-bindings.zsh
. /usr/share/fzf/completion.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
# TODO: Fix Ctrl+R not working under bindkey -v if we ever get to using it
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall
. $HOME/cfg/sh/interactive/aliases.sh
export PS1="%d>"

