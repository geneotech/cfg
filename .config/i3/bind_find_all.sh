LOCATION=$(find -L $(cat ~/.config/i3/find_all_locations) | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'find:')

[[ -z $LOCATION ]] && return

if [[ -d $LOCATION ]] 
then
  $TERMINAL -e ranger $LOCATION
else
 cd $(dirname $LOCATION)
 RIFLE_RESULT=$(rifle $LOCATION)
 echo $RIFLE_RESULT
 if [[ ! -z $RIFLE_RESULT ]]
 then
   $TERMINAL -e ranger --selectfile=$LOCATION 
 fi 
fi
