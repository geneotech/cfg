#i3-msg "[title=NVIM] focus"
#xdotool key super+p

LOCATION=$(find -L $(cat ~/.config/i3/find_all_locations) -not -iwholename '*.git*' -not -iwholename '*_site*' | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'find:')

[[ -z $LOCATION ]] && return

if [[ -d $LOCATION ]] 
then
  IN_TERMINAL ranger $LOCATION
else
 cd $(dirname $LOCATION)
 RIFLE_RESULT=$(rifle $LOCATION)
 echo $RIFLE_RESULT
 if [[ ! -z $RIFLE_RESULT ]]
 then
   # IN_TERMINAL ranger --selectfile=$LOCATION
   # We can anyway open ranger from vim quickly, so let's just edit it as text
   # $VISUAL $LOCATION
 fi 
fi
