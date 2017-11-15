LOCATION=$(find -L $(cat ~/.config/i3/find_all_locations) | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'open containing folder:')

[[ -z $LOCATION ]] && return

if [[ -d $LOCATION ]] 
then
  terminator -e "ranger $LOCATION"
else
  terminator -e "ranger --selectfile=$LOCATION" 
fi
