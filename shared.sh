PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="/home/pbc/.gem/bin:$PATH"
export GEM_HOME=$HOME/.gem

# Don't freeze editor on Ctrl+S
#stty -ixon
export TERMINAL=alacritty
export EDITOR=nvim
export VISUAL=~/cfg/runnvim.sh
alias mkexe='sudo chmod +x '
alias gitmkexe='git update-index --chmod=+x '
# my text file extensions for use in grep searches
export EXTS=""
source ~/.config/i3/workspace/current
alias ag='ag --hidden'
alias nuke='pkill -f '
alias interrupt='pkill -f --signal 2 '
alias int='interrupt '
alias spac='sudo shutdown -h now'
alias ls='ls --color=auto'
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
alias serve="bundle exec jekyll serve"
alias xtr="/bin/extract"

alias rmorphans="sudo pacman -Rns $(pacman -Qtdq) "
alias rmpkg="yaourt -Rsn "
alias prmpkg="sudo pacman -Rsn "
alias nogpg='yaourt --m-arg "--skippgpcheck"'
alias uppkgs='yaourt -Su --aur '
LASTERR_PATH=/tmp/last_error.txt
LASTERR_PATH_COLOR=/tmp/last_error_color.txt

function rmlogs() {
	rm $LASTERR_PATH
	rm $LASTERR_PATH_COLOR
}

function stripcodes() {
	sed -i -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' $1
	sed -i 's/\r$//g' $1
	sed -i -e '1d' $1
}

# Handy building aliases
alias clnerr='stripcodes $LASTERR_PATH'

function make_with_logs() {
	MAKE_TARGET=$1
	TARGET_DIR=$2

	rmlogs

	script -q -c "make $MAKE_TARGET -j5 -C $TARGET_DIR" $LASTERR_PATH > /dev/pts/1 
}

function make_current() {
	MAKE_TARGET=$1

	make_with_logs $MAKE_TARGET build/current
}

function handle_last_errors() {
	ERRORS=$(grep -e "error:" $LASTERR_PATH)
	LINKER_ERRORS=$(grep -e "error: ld" $LASTERR_PATH)
	
	if [[ ! -z $ERRORS && -z $LINKER_ERRORS ]]
	then
		cp $LASTERR_PATH $LASTERR_PATH_COLOR
		clnerr
		$(i3-msg "[title=NVIM] focus")
	else
		rmlogs
	fi
}

function vim_target() {
	interrupt make
	cd $WORKSPACE
	make_current $1
	handle_last_errors
}

function vim_build() {
	vim_target all
}

function vim_debug() {
	vim_target conque_debug
}

function vim_run() {
	vim_target run
}

function reb() {
	git fetch upstream
	git checkout master
	git rebase upstream/master
}

alias cmkd="cmake/build.sh Debug x64 '-DBUILD_IN_CONSOLE_MODE=1'"
alias cmkr="cmake/build.sh Release x64 '-DBUILD_IN_CONSOLE_MODE=1'"
