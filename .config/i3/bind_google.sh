LOCATION=$(rofi -hide-scrollbar -dmenu -i -p 'google')
[[ ! -z "$LOCATION" ]] && firefox -- "google.com/search?q="