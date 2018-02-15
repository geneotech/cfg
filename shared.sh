# Important variables
# Ruby setup
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="/home/pbc/.gem/bin:$PATH"

export GEM_HOME=$HOME/.gem

source ~/cfg/vim_builders.sh

# Program aliases
alias ls="exa"
alias gcleanup="git reset --hard; git clean -d -x -f "
alias meldh="meld $PWD"
alias serve="bundle exec jekyll serve"
alias ag='ag --hidden'
alias diskspace='sudo gdmap -f "/"'

# Building aliases
alias cmkd="cmake/build.sh Debug x64 '-DBUILD_IN_CONSOLE_MODE=1'"
alias cmkr="cmake/build.sh Release x64 '-DBUILD_IN_CONSOLE_MODE=1'"

alias cusr="rm -rf hypersomnia/cache/usr"
alias cch="rm -rf hypersomnia/cache"
alias ced="rm -rf hypersomnia/cache/usr/editor"

# Common tasks aliases
alias ptsy='ls /dev/pts'
alias procki='ps aux | ag '
alias rbt='sudo reboot'
alias mycha='source ~/.xinitrc'
alias nuke='pkill -f '
alias int='interrupt '
alias spac='sudo shutdown -h now'

# Common fs aliases
alias fixspaces='for f in *\ *; do mv "$f" "${f// /_}"; done'
alias filecnt='sudo find . -xdev -type f | cut -d "/" -f 2 | sort | uniq -c | sort -n'
alias whenlm="stat -c '%y' "
alias mkexe='sudo chmod +x '
alias gitmkexe='git update-index --chmod=+x '
alias wszystkim='sudo chmod 777 -R .'

# System maintenance aliases
alias pls='sudo $(fc -ln -1)'
alias rmorphans="sudo pacman -Rns $(pacman -Qtdq) "
alias rmpkg="yaourt -Rsn "
alias prmpkg="sudo pacman -Rsn "
alias nogpg='yaourt --m-arg "--skippgpcheck"'
alias uppkgs='yaourt -Syu --aur '
alias journalgetsize='journalctl --disk-usage'

# Forgotten aliases
alias relx='xrdb ~/.Xresources'
alias upx='sudo xrdb ~/.Xresources'

function journalsize() {
	sudo journalctl --vacuum-size=$1
}

