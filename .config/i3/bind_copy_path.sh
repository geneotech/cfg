LOCATION=$(ag -U -g --hidden '' $(cat ~/.config/i3/find_all_locations) 2> /dev/null | rofi -hide-scrollbar -dmenu -i -p 'copy path')
echo -n $LOCATION | xclip -selection clipboard
