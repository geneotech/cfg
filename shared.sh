stty -ixon
export TERMINAL=alacritty
export EDITOR=vim
export VISUAL=~/runvim.sh
alias mkexe='sudo chmod +x '
# my text file extensions for use in grep searches
export EXTS=""
source ~/.config/i3/workspace/current
alias spac='sudo shutdown -h now'
alias ls='ls --color=auto'
alias dusage='sudo gdmap &!; exit'
alias relx='xrdb ~/.Xresources'
alias filecnt='sudo find . -xdev -type f | cut -d "/" -f 2 | sort | uniq -c | sort -n'
alias diskspace='sudo gdmap -f "/"'
alias upx='sudo xrdb ~/.Xresources'
alias pls='sudo $(fc -ln -1)'
alias gst="git status "
alias glg="git log "
alias gcm="git commit -m "
alias gdiff='git diff '
alias gdifft='git difftool -d '
alias gadd="git add "
alias gall="git add ."
alias gcmall="gall; gcm "
alias gpush="git push "
alias gclean="git clean -d -x -f "
alias gcleanup="git reset --hard; git clean -d -x -f "
alias meldh="meld $PWD"

alias rmorphans="sudo pacman -Rns $(pacman -Qtdq) "
alias rmpkg="yaourt -Rsn "
alias prmpkg="sudo pacman -Rsn "

LASTERR_PATH=/tmp/last_error.txt

# Jump to last error in vim
alias vj='vim --remote-send "<ESC>:lfile $LASTERR_PATH <CR>"; $(i3-msg "[title=VIM] focus");'

function stripcodes() {
	sed -i -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' $1
	sed -i 's/\r$//g' $1
	sed -i -e '1d' $1
}

alias clnerr='stripcodes $LASTERR_PATH'

alias cmkd="cmake/build.sh Debug x64 '-DBUILD_IN_CONSOLE_MODE=1'"
alias cmkr="cmake/build.sh Release x64 '-DBUILD_IN_CONSOLE_MODE=1'"

function make_with_logs() {
	MAKE_TARGET=$1
	TARGET_DIR=$2

	script -q -c "make $MAKE_TARGET -j5 -C $TARGET_DIR" $LASTERR_PATH > /dev/pts/1 
}

function make_current() {
	MAKE_TARGET=$1

	make_with_logs $1 build/current
}

function vim_target() {
	vim --remote-send "<ESC>:wa<CR>"
	cd $WORKSPACE
	make_current $1

	ERRORS=$(grep -e "error" $LASTERR_PATH)
	
	if [[ ! -z $ERRORS ]]
	then
		clnerr
		vj
	fi
}

function vim_make() {
	vim_target all
}

function vim_run() {
	vim_target run
}

alias mkd='script -q -c "make run -j5 -C build/Debug-x64" $LASTERR_PATH > /dev/pts/1; clnerr'
alias mkr="make -j5 -C build/Release-x64"

alias mkdr="make run -j5 -C build/Debug-x64 2>&1 | tee /tmp/last_error.txt"
alias mkdd="make debug -j5 -C build/Debug-x64"
alias mkrr="make run -j5 -C build/Release-x64"
