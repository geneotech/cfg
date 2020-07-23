# Important variables
# Ruby setup
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="$HOME/.gem/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/rider/bin:$PATH"
PATH="$HOME/SVP4:$PATH"
PATH="/opt/unreal-engine/Engine/Binaries/Linux:$PATH"
PATH=~/bin:$PATH
 
export GEM_HOME=$HOME/.gem

vw () {
	echo "export OUTPUT_TERM=$(tty)" > /tmp/viewing_tty
}

vw

. ~/cfg/sh/build/vim_builders.sh
. ~/cfg/sh/open/workspace/current
. ~/cfg/sh/interactive/pngize.sh
. ~/cfg/sh/interactive/replace_color.sh
. ~/cfg/sh/interactive/rsync_aliases.sh

# Program aliases
alias ls="exa"
alias serve="bundle exec jekyll serve"
alias ag='ag --hidden'
alias diskspace='sudo gdmap -f "/"'

# additional git aliases

far() {
  # mass find and replace
  ag -l -0 "$1"   | xargs -0 sed -i -e "s/$1/$2/g"
}

farw() {
  # mass find and replace word
  git ls-files -z | xargs -0 sed -i -e "s/\b$1\b/$2/g"
}

# Restores the most recent version of a deleted file
grestore () {
	git checkout $(git rev-list -n 1 HEAD -- $1)^ -- $1
}

gexport () {
	git commit -m "Making a commit to export the changes"
	git diff-tree -r --no-commit-id --name-only --diff-filter=ACMRT HEAD | xargs tar -rf "/bup/$1-backup.tar"
	git reset --soft HEAD~
}

zjebanylfs()
{
	git lfs uninstall
	git reset --hard
	git lfs install
	git lfs pull
	git reset --hard
	git clean -dxf
}

wf2() {
	waifu2x -i $1
}

alias zbd='zajeb discord'

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

# git aliases

alias gs='git show'
alias gfe='git fetch'
alias gbr='git branch'
alias gre='git reset'
alias gsh='git show'
alias grv='git remote -v'
alias try='git stash -k'
alias gap='git stash apply'
alias gforget='git rm --cached'
alias grforget='git rm -r --cached'
alias gch='git checkout'
alias gpu='git pull'
alias gc='git commit -m'
alias ga='git add'
alias gall='git add --all'
alias g='git status'
alias gg='git status | ag'
alias gd='git diff'
alias gcl='git clone'
alias gca='git add --all && git commit -m'
alias gamd='git commit --amend -m'
alias gano='git commit --amend --no-edit'
alias gchc='git cherry-pick --continue'
alias grm='git rm'
alias grem='git remote'
alias glg='git log --stat'
alias gl='git log'
alias gallexisted='git log --pretty=format: --name-only --diff-filter=A | sort -u'
alias agq="ag -Q"
alias chdalej="GIT_EDITOR=true git cherry-pick --continue"
alias rbdalej="GIT_EDITOR=true git rebase --continue"

nasz() {
  git checkout --ours $1
  git add $1
}

ich() {
  git checkout --theirs $1
  git add $1
}

function bfpushupto()
{
	git push origin $1:"feature/s16/wz_opt_new"
}

function amenddate() {
	NEWDATE="$1 2019 +0100"

	GIT_COMMITTER_DATE="$NEWDATE" git commit --amend --no-edit --date "$NEWDATE"
	git rebase --continue
}

function amenddateyr() {
	NEWDATE="$1 +0100"

	GIT_COMMITTER_DATE="$NEWDATE" git commit --amend --no-edit --date "$NEWDATE"
	git rebase --continue
}

function mkssh() {
	git remote set-url $1 git@github.com:$2/$3.git
}

function origssh() {
	mkssh origin $1 $2
}

# Building aliases
alias ucl="export CC=clang; export CXX=clang++;"
alias ugcc="export CC=clang; export CXX=clang++;"
alias rmbu="rm -rf build"

alias cmkdg="ucl; export BUILD_FOLDER_SUFFIX=g; 		  cmake/build.sh Debug x64 '-DGENERATE_DEBUG_INFORMATION=1 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkdf="ucl; export BUILD_FOLDER_SUFFIX=fast; 	  cmake/build.sh Debug x64 '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkdglfw="ucl; export BUILD_FOLDER_SUFFIX=glfw; 	  cmake/build.sh Debug x64 '-DUSE_GLFW=1 -DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkprglfw="ucl; export BUILD_FOLDER_SUFFIX=glfw; 	  cmake/build.sh Release x64 '-DUSE_GLFW=1 -DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkdfs="ucl; export BUILD_FOLDER_SUFFIX=faststatic; 	  cmake/build.sh Debug x64 '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1 -DSTATIC_LINK=1' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkdfsnol="ucl; export BUILD_FOLDER_SUFFIX=faststaticnol; 	  cmake/build.sh Debug x64 '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1 -DSTATIC_LINK=1 -DPREFER_LIBCXX=0' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkrf="ucl; export BUILD_FOLDER_SUFFIX=fast; 	  cmake/build.sh RelWithDebInfo x64 '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkrg="ucl; export BUILD_FOLDER_SUFFIX=g; 	  cmake/build.sh RelWithDebInfo x64 '-DGENERATE_DEBUG_INFORMATION=1 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkrgs="ucl; export BUILD_FOLDER_SUFFIX=gstatic; 	  cmake/build.sh RelWithDebInfo x64 '-DGENERATE_DEBUG_INFORMATION=1 -DBUILD_IN_CONSOLE_MODE=1 -DSTATIC_LINK=1' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkrfs="ucl; export BUILD_FOLDER_SUFFIX=faststatic; 	  cmake/build.sh RelWithDebInfo x64 '-DSTATIC_LINK=1 -DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"

alias cmkdfgcc="ugcc; export BUILD_FOLDER_SUFFIX=fast; 	  cmake/build.sh Debug x64 '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"

alias cmkdgcc="ugcc; cmake/build.sh Debug x64 '-DBUILD_PROPERTY_EDITOR=0 -DBUILD_IN_CONSOLE_MODE=1'"
alias cmkrgcc="ugcc; cmake/build.sh RelWithDebInfo x64 '-DBUILD_PROPERTY_EDITOR=0 -DBUILD_IN_CONSOLE_MODE=1'"
alias cmkrgccfull="ugcc; cmake/build.sh RelWithDebInfo x64 '-DBUILD_IN_CONSOLE_MODE=1'"
alias cmkr="ucl; cmake/build.sh RelWithDebInfo x64 clang clang++ '-DBUILD_IN_CONSOLE_MODE=1'"

alias cmkrsanitize="ucl; export BUILD_FOLDER_SUFFIX=sanit; 	  cmake/build.sh RelWithDebInfo x64 '-DENABLE_THREADSANITIZER=1 -DBUILD_IN_CONSOLE_MODE=1' export BUILD_FOLDER_SUFFIX=\"\";"

# Production build
alias cmkpr="cmake/build.sh Release x64 clang clang++ '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1'"
alias cmkprg="export BUILD_FOLDER_SUFFIX=prod-debug; cmake/build.sh Release x64 clang clang++ '-DGENERATE_DEBUG_INFORMATION=1 -DBUILD_IN_CONSOLE_MODE=0' export BUILD_FOLDER_SUFFIX=\"\";"
alias cmkds="export BUILD_FOLDER_SUFFIX=dedicated-server; cmake/build.sh Release x64 clang clang++ '-DGENERATE_DEBUG_INFORMATION=0 -DBUILD_IN_CONSOLE_MODE=1 -DHYPERSOMNIA_DEDICATED_SERVER=1'"

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
alias cusr="rm -rf hypersomnia/user"
alias cgen="rm -rf hypersomnia/cache"
alias catl="rm -rf hypersomnia/cache/atlases"
alias ced="rm -rf hypersomnia/user/editor"
alias rmau="rm -rf /tmp/autosave"

alias n="sudo dhcpcd"

# System maintenance tasks aliases
journalsize() {
	sudo journalctl --vacuum-size=$1
}

relinksh () {
	sudo ln -sfT $1 /usr/bin/sh
}

relinketcx11() {
	sudo $HOME/cfg/sh/link_etc_X11 $HOME/cfg/etc/X11
}

alias dhealth='sudo smartctl -a'
alias mkmkinit='sudo mkinitcpio -p linux'
alias mounty='mount | column -t'
alias rmpwd='sudo passwd -d '
alias chksh='readlink /usr/bin/sh'
alias journalgetsize='journalctl --disk-usage'
alias mody='lsmod | ag'

sw () {
	echo "export WORKSPACE=$PWD" > ~/cfg/sh/open/workspace/current
}

# Package management aliases
alias dawaj="yay --noconfirm "
alias rmorphans="yay -Rsn $(yay -Qtdq)"
alias rmpkg="yay -Rsn "
alias wyjeb="yay -Rsn "
# Recursive
alias rrmpkg="yay -Rsnc "
alias prmpkg="sudo pacman -Rsn "
alias nogpg='yay --m-arg "--skippgpcheck"'
alias uppkgs='yay -Syu'
alias clcache='yay -Sc && sudo pacman -Scc'
alias ins='yay -S'

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
alias mkexe='chmod +x '
alias gitmkexe='git update-index --chmod=+x '
alias wszystkim='sudo chmod 777 -R .'

alias rg='IN_TERMINAL ranger $PWD'

save_clipboard_to() {
	new_path=$1

	if [[ -z "$1" ]]
	then
		new_path="/tmp/clipboard.png"
	fi

	xclip -selection clipboard -t image/png -o > $new_path
}

# Common tasks aliases

alias i3exit='i3-msg exit'
alias ypng='xclip -selection clipboard -t image/png -i '
alias svcl='save_clipboard_to'
alias start_weston='source ~/cfg/sh/interactive/start_weston.sh'
alias coto='yay -Qi'
alias zajeb='pkill -f --signal=SIGKILL '
alias nuke='pkill -f '
alias ptsy='ls /dev/pts'
alias procki='ps aux | ag '
alias rbt='reboot'
alias rbtwin='sudo reboot_to_windows'
alias mycha='. ~/.xinitrc'
alias interrupt='pkill -f --signal 2 '
alias int='interrupt '
alias spac='shutdown -h now'
alias im="interrupt ninja"
alias xtr='. ~/cfg/sh/interactive/extract.plugin.zsh; extract '
alias pls='sudo $(fc -ln -1)'
alias run='./run.sh'

# adb aliases
alias adi='adb install'
alias add='adb devices -l'
alias adr='adb kill-server && adb start-server'

# Forgotten aliases
alias relx='xrdb ~/.Xresources'
alias upx='sudo xrdb ~/.Xresources'

# Navigation aliases

fd () {
	export FZF_DEFAULT_OPTS=''

	NEWLOC=$(fzf)

	if [ ! -z $NEWLOC ]
	then
		cd "$(dirname $NEWLOC)"
	fi
}

fr () {
	export FZF_DEFAULT_OPTS=''

	NEWLOC=$(fzf)

	if [ ! -z $NEWLOC ]
	then
		rifle "$NEWLOC"
	fi
}

# ssh

sshuj() {
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa
}

alias cli="pushd hypersomnia; ../build/current/Hypersomnia --connect; popd"
alias srv="pushd hypersomnia; ../build/current/Hypersomnia --server; popd"
alias dsrv="pushd hypersomnia; ../build/current/Hypersomnia --dedicated-server; popd"
alias msrv="pushd hypersomnia; ../build/current/Hypersomnia --masterserver; popd"

trims() {
	ffmpeg -ss $2 -i "$1.mkv" -c copy -t $3 -map 0:v:0 -map 0:a:1 "$1_out.mkv"
}

replaceaudio() {
	ffmpeg -i /bup/rpl/in.mp4 -i /bup/rpl/in.wav -c:v copy -map 0:v:0 -map 1:a:0 /bup/rpl/out.mp4
}

LOCAL_ZSH_RC="$WORKSPACE/.zshrc"

if [ -f $LOCAL_ZSH_RC ]
then
. $LOCAL_ZSH_RC
fi

name(){
  arg1=$1
  arg2=$2
  echo "$arg1 $arg2"
}

# python aliases
alias pym='python main.py'

# Raspberry pi aliases

RASPBERRYPI_ADDR=raspberrypi
RASPBERRY_HOST_FILE=/tmp/raspberry_host

if [ -f $RASPBERRY_HOST_FILE ]
then
	. $RASPBERRY_HOST_FILE
fi

setip() {
	echo "export RASPBERRYPI_ADDR=$1" > $RASPBERRY_HOST_FILE
	. $RASPBERRY_HOST_FILE
}

ppi() {
	ping $RASPBERRYPI_ADDR
}

spi() {
	ssh pi@$RASPBERRYPI_ADDR
}

sfs() {
	sshfs pi@$RASPBERRYPI_ADDR:/ ~/sfs -C
}

net_on() {
	sudo ifconfig enp3s0 up
}

net_off() {
	sudo ifconfig enp3s0 down
}

test_in_tmp() {
	rm -rf /tmp/test_hyper

	cp -rf hypersomnia /tmp/test_hyper
	cp -rf build/current/Hypersomnia /tmp/test_hyper/Hypersomnia

	pushd /tmp/test_hyper
	./Hypersomnia
	popd
}

unph() {
	rm -rf hypersomnia
	chmod +x Hypersomnia-for-Linux.sfx
	./Hypersomnia-for-Linux.sfx
	cd hypersomnia
}

server_upgrade() {
  pushd ~/rep/arena.hypersomnia.xyz/user
  zsh vim_build.sh && zsh vim_run.sh
  popd
}

server_restart() {
  pushd ~/rep/arena.hypersomnia.xyz/user
  zsh vim_run.sh
  popd
}

sensible_mp4() {
  ffmpeg -i $1 \
    -c:v libx264 -crf 23 -profile:v baseline -level 3.0 -pix_fmt yuv444p \
    -c:a aac -ac 2 -b:a 256k \
    -movflags faststart \
    output.mp4
}

windows_server() {
  cat ~/.ssh/wserver_pass | /usr/bin/rdesktop -r disk:tmp=/home/pbc/Desktop -g 1440x900 -P -z -x l -r sound:off -u Administrator $1 -p -
}

mount_windows() {
  sudo mount /dev/sda3 /media/win
}

mp4towebm() {
  ffmpeg  -i $1  -b:v 0  -crf 30  -pass 1  -an -f webm /dev/null
  ffmpeg  -i $1  -b:v 0  -crf 30  -pass 2  $2
}
