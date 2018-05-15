LOCATION=$(find -L $(cat ~/cfg/sh/open/find_all_locations) | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'open shell in')

[[ -z $LOCATION ]] && return

if [[ -d $LOCATION ]] 
then
  cd $LOCATION
else
  cd $(dirname $LOCATION)
fi
IN_TERMINAL zsh
