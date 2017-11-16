LOCATION=$(find -L $WORKSPACE | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'go to:')

[[ -z $LOCATION ]] && return

if [[ -d $LOCATION ]] 
then
  terminator -e "ranger $LOCATION"
else
 cd $(dirname $LOCATION)
 RIFLE_RESULT=$(rifle $LOCATION)
 if [[ ! -z $RIFLE_RESULT ]]
 then
   terminator -e "ranger --selectfile=$LOCATION" 
 fi 
fi
