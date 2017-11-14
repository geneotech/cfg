LOCATION=$(find -L /home /etc /srv /boot /usr/share /bin | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'copy path:')
echo -n $LOCATION | xclip -selection clipboard
