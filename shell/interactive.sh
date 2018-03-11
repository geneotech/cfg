# Important variables
# Ruby setup
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="/home/pbc/.gem/bin:$PATH"

export GEM_HOME=$HOME/.gem

vw () {
	echo "export OUTPUT_TERM=$(tty)" > /tmp/viewing_tty
}

vw

. ~/cfg/shell/vim_builders.sh
. ~/cfg/.config/i3/workspace/current

# Program aliases
alias nt='export LAUNCH_TERMINAL=true; nvim'
alias ls="exa"
alias meldh="meld $PWD"
alias serve="bundle exec jekyll serve"
alias ag='ag --hidden'
alias diskspace='sudo gdmap -f "/"'

# additional git aliases

# Restores the most recent version of a deleted file
grestore () {
	git checkout $(git rev-list -n 1 HEAD -- $1)^ -- $1
}

alias gp='git push'
alias gc='git commit -m'
alias gall='git add --all'
alias gst='git status'
alias gca='git add --all && git commit -m'
alias gamd='git commit --amend -m'
alias glg='git log --stat'
alias gallexisted='git log --pretty=format: --name-only --diff-filter=A | sort -u'
alias gcleanup="git reset --hard; git clean -d -x -f "

fd () {
	export FZF_DEFAULT_OPTS=''

	NEWLOC=$(fzf)

	if [ ! -z $NEWLOC ]
	then
		cd $(dirname $NEWLOC)
	fi
}

fr () {
	export FZF_DEFAULT_OPTS=''

	NEWLOC=$(fzf)

	if [ ! -z $NEWLOC ]
	then
		rifle $NEWLOC
	fi
}

# Building aliases
alias ucl="export CC=clang; export CXX=clang++;"
alias cmkd="cmake/build.sh Debug x64 clang clang++ '-DBUILD_IN_CONSOLE_MODE=1'"
alias cmkdgcc="cmake/build.sh Debug x64 gcc g++ '-DBUILD_IN_CONSOLE_MODE=1'"
alias cmkr="cmake/build.sh Release x64 clang clang++ '-DBUILD_IN_CONSOLE_MODE=1'"
alias cmkc="cmake/clean.sh"
alias mkc="pushd build/current; make clean; popd"

alias cusr="rm -rf hypersomnia/cache/usr"
alias cch="rm -rf hypersomnia/cache"
alias ced="rm -rf hypersomnia/cache/usr/editor"

# Common tasks aliases
alias zajeb='pkill -f --signal=SIGKILL '
alias nuke='pkill -f '
alias ptsy='ls /dev/pts'
alias procki='ps aux | ag '
alias rbt='sudo reboot'
alias mycha='. ~/.xinitrc'
alias interrupt='pkill -f --signal 2 '
alias int='interrupt '
alias spac='sudo shutdown -h now'
alias mounty='mount | column -t'
alias im="interrupt make"
alias rmpwd='sudo passwd -d '

# Common fs aliases
alias mkb='mkdir build && cd build'
alias clb='cd ../; rm -rf build; mkdir build; cd build'
alias ds='du -sh * | sort -rh'
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

journalsize() {
	sudo journalctl --vacuum-size=$1
}

