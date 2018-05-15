. ~/.config/i3/workspace/current
cd $WORKSPACE/build

CONFIGURATIONS=$(ls -1 | sed '/current/d' | sed '/last/d')

CURRENT_CONFIGURATION=$(readlink current)
NEW_CONFIGURATION=$(echo $CONFIGURATIONS | rofi -hide-scrollbar -dmenu -i -p "switch from $CURRENT_CONFIGURATION to")
echo "+$NEW_CONFIGURATION+"

if [[ ! -z $NEW_CONFIGURATION ]]
then
	rm current
	ln -s $NEW_CONFIGURATION current

	# echo "Changing to $NEW_CONFIGURATION"
else
	# echo "No new cfg specified. Doing nothing."
fi
