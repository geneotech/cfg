# Sort by line length.
# Thanks to https://stackoverflow.com/a/5917762/503776
LOCATION=$(find -L $WORKSPACE | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- | rofi -hide-scrollbar -dmenu -i -p 'go to:')

[[ -z $LOCATION ]] && return

if [[ -d $LOCATION ]] 
then
  $TERMINAL -e ranger $LOCATION
else
 cd $(dirname $LOCATION)
 RIFLE_RESULT=$(rifle $LOCATION)
 if [[ ! -z $RIFLE_RESULT ]]
 then
   $TERMINAL -e ranger --selectfile=$LOCATION
 fi 
fi
