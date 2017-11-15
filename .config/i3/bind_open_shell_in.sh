LOCATION=$(find -L $(cat ~/.config/i3/find_all_locations) | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'open shell in:')

[[ -z $LOCATION ]] && return

if [[ -d $LOCATION ]] 
then
  cd $LOCATION
else
  cd $(dirname $LOCATION)
fi
terminator
