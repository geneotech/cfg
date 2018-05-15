export CXX=clang++
export CC=clang
export EDITOR=nvim-EDITOR
export VISUAL=nvim-EDITOR

IN_TERMINAL() {
	WAYLAND_DISPLAY=
	alacritty -e $@
}
