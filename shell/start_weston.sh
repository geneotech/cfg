if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  export XKB_DEFAULT_LAYOUT=pl

  xmodmap -e "clear lock"
  xmodmap -e "keysym Caps_Lock = Escape"
  setxkbmap pl

  exec sway
fi

