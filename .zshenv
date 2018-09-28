export EDITOR=nvim-EDITOR
export VISUAL=nvim-EDITOR
export PATH="$HOME/.cargo/bin:$PATH"
export CXX=clang++
export CC=clang

IN_TERMINAL() {
	WAYLAND_DISPLAY=
	alacritty -e $@
}

export TERMINAL=alacritty
