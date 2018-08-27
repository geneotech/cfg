# Important variables
# Ruby setup
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="/home/pbc/.gem/bin:$PATH"
PATH="/home/pbc/.cargo/bin:$PATH"

export GEM_HOME=$HOME/.gem

vw () {
	echo "export OUTPUT_TERM=$(tty)" > /tmp/viewing_tty
}

vw

. ~/cfg/sh/build/vim_builders.sh
. ~/cfg/sh/open/workspace/current
. ~/cfg/sh/interactive/pngize.sh

# Program aliases
alias ls="exa"
alias serve="bundle exec jekyll serve"
alias ag='ag --hidden'
alias diskspace='sudo gdmap -f "/"'

# additional git aliases

# Restores the most recent version of a deleted file
grestore () {
	git checkout $(git rev-list -n 1 HEAD -- $1)^ -- $1
}

gexport () {
	git commit -m "Making a commit to export the changes"
	git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT HEAD | xargs tar -rf "/bup/$1-backup.tar"
	git reset --soft HEAD~
}

wf2() {
	waifu2x -i $1
}

focus() {
	zajeb discord
	zajeb Discord
	zajeb firefox
}

upsub() {
	subname=$1
	target_branch=$2

	if [[ -z "$2" ]]
	then
		target_branch="master"
	fi

	pushd $subname
	git checkout $target_branch
	git pull
	popd
}

update_trivial_3rdparties() {
	D=./src/3rdparty

	upsub $D/Catch 
	upsub $D/concurrentqueue
	upsub $D/enet
	upsub $D/freetype
	upsub $D/lodepng
	upsub $D/ogg
	upsub $D/openal-soft
	upsub $D/polypartition
	upsub $D/rectpack2D
	upsub $D/sol2 develop
	upsub $D/vorbis

	upsub cmake/Introspector-generator hypersomnia
	upsub hypersomnia/scripts/serpent
}

alias try='git stash -k'
alias gap='git stash apply'
alias gch='git checkout'
alias gp='git push'
alias gc='git commit -m'
alias gall='git add --all'
alias gst='git status'
alias gca='git add --all && git commit -m'
alias gamd='git commit --amend -m'
alias gano='git commit --amend --no-edit'
alias glg='git log --stat'
alias gallexisted='git log --pretty=format: --name-only --diff-filter=A | sort -u'
alias gcleanup="git reset --hard; git clean -d -x -f "

# Building aliases
alias ucl="export CC=clang; export CXX=clang++;"
alias rmbu="rm -rf build"

alias cmkdg="export BUILD_FOLDER_SUFFIX=g; 		  cmake/build.sh Debug x64 clang clang++ '-DGENERATE_DEBUG_INFORMATION=1 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkdf="export BUILD_FOLDER_SUFFIX=fast; 	  cmake/build.sh Debug x64 clang clang++ '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkrf="export BUILD_FOLDER_SUFFIX=fast; 	  cmake/build.sh RelWithDebInfo x64 clang clang++ '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"

alias cmkdfgcc="export BUILD_FOLDER_SUFFIX=fast; 	  cmake/build.sh Debug x64 gcc gcc++ '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"

alias cmkdgcc="cmake/build.sh Debug x64 gcc g++ '-DBUILD_PROPERTY_EDITOR=0 -DBUILD_IN_CONSOLE_MODE=1'"
alias cmkrgcc="cmake/build.sh RelWithDebInfo x64 gcc g++ '-DBUILD_PROPERTY_EDITOR=0 -DBUILD_IN_CONSOLE_MODE=1'"
alias cmkrgccfull="cmake/build.sh RelWithDebInfo x64 gcc g++ '-DBUILD_IN_CONSOLE_MODE=1'"
alias cmkr="cmake/build.sh RelWithDebInfo x64 clang clang++ '-DBUILD_IN_CONSOLE_MODE=1'"

# Production build
alias cmkpr="cmake/build.sh Release x64 clang clang++ '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1'"

cmkmin() {
	export BUILD_FOLDER_SUFFIX=minimal;
	cmake/build.sh $1 x64 clang clang++ '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1 -DBUILD_PROPERTY_EDITOR=0 -DBUILD_ENET=0 -DBUILD_VERSION_FILE_GENERATOR=0'
	export BUILD_FOLDER_SUFFIX=;
}

cmkdmin() {
	cmkmin Debug
}

cmkrmin() {
	cmkmin RelWithDebInfo
}

alias cmkc="pushd build/current; cmake $OLDPWD; popd"
alias cusr="rm -rf hypersomnia/cache/usr"
alias cgen="rm -rf hypersomnia/cache/gen"
alias catl="rm -rf hypersomnia/cache/gen/atlases"
alias cch="rm -rf hypersomnia/cache"
alias ced="rm -rf hypersomnia/cache/usr/editor"

# System maintenance tasks aliases
journalsize() {
	sudo journalctl --vacuum-size=$1
}

relinksh () {
	sudo ln -sfT $1 /usr/bin/sh
}

alias mkgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mkmkinit='sudo mkinitcpio -p linux'
alias mounty='mount | column -t'
alias rmpwd='sudo passwd -d '
alias chksh='readlink /usr/bin/sh'
alias journalgetsize='journalctl --disk-usage'
alias mody='lsmod | ag'

# Package management aliases
alias dawaj="yaourt --noconfirm "
alias rmorphans="yaourt -Rsn $(yaourt -Qtdq)"
alias rmpkg="yaourt -Rsn "
# Recursive
alias rrmpkg="yaourt -Rsnc "
alias prmpkg="sudo pacman -Rsn "
alias nogpg='yaourt --m-arg "--skippgpcheck"'
alias uppkgs='yaourt -Syu --aur '
alias clcache='yaourt -Scy'

# Filesystem task aliases
alias peny='lsblk -f'

pen() {
	device_name=$1

	if [[ -z "$1" ]]
	then
		device_name="sdc"
	fi

	pmount -D $device_name
}

unpen() {
	device_name=$1

	if [[ -z "$1" ]]
	then
		device_name="sdc"
	fi

	pumount -D $device_name
}

alias mkb='mkdir build && cd build'
alias clb='cd ../; rm -rf build; mkdir build; cd build'
alias ds='du -sh * | sort -rh'
alias dsh='du -sh .* | sort -rh'
alias fixspaces='for f in *\ *; do mv "$f" "${f// /_}"; done'
alias filecnt='sudo find . -xdev -type f | cut -d "/" -f 2 | sort | uniq -c | sort -n'
alias whenlm="stat -c '%y' "
alias mkexe='sudo chmod +x '
alias gitmkexe='git update-index --chmod=+x '
alias wszystkim='sudo chmod 777 -R .'

save_clipboard_to() {
	new_path=$1

	if [[ -z "$1" ]]
	then
		new_path="/tmp/clipboard.png"
	fi

	xclip -selection clipboard -t image/png -o > $new_path
}

# Common tasks aliases
alias ypng='xclip -selection clipboard -t image/png -i '
alias svcl='save_clipboard_to'
alias start_weston='source ~/cfg/sh/interactive/start_weston.sh'
alias coto='yaourt -Qi'
alias zajeb='pkill -f --signal=SIGKILL '
alias nuke='pkill -f '
alias ptsy='ls /dev/pts'
alias procki='ps aux | ag '
alias rbt='sudo reboot'
alias mycha='. ~/.xinitrc'
alias interrupt='pkill -f --signal 2 '
alias int='interrupt '
alias spac='sudo shutdown -h now'
alias im="interrupt ninja"
alias xtr='. ~/cfg/sh/interactive/extract.plugin.zsh; extract '
alias pls='sudo $(fc -ln -1)'

# Forgotten aliases
alias relx='xrdb ~/.Xresources'
alias upx='sudo xrdb ~/.Xresources'

# Navigation aliases

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
