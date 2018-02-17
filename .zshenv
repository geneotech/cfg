export EDITOR=nvim
TERMINAL_IMPL () { alacritty --working-directory=$PWD $@ }
VISUAL_IMPL () { TERMINAL_IMPL -e $EDITOR $@ }
export TERMINAL=TERMINAL_IMPL
export VISUAL=VISUAL_IMPL
