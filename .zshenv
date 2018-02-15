export EDITOR=nvim
function TERMINAL_IMPL() { alacritty --working-directory=$PWD $@ }
function VISUAL_IMPL() { TERMINAL_IMPL -e $EDITOR $@ }

export TERMINAL=TERMINAL_IMPL
export VISUAL=VISUAL_IMPL
