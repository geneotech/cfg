LOCATION=$(find -L $WORKSPACE | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'go to:')

[[ -z $LOCATION ]] && return

if [[ -d $LOCATION ]] 
then
  xterm -e "ranger $LOCATION"
else
  RIFLE_RESULT=$(rifle $LOCATION)
 if [[ ! -z $RIFLE_RESULT ]]
 then
   xterm -e "ranger --selectfile=$LOCATION" 
 fi 
fi
