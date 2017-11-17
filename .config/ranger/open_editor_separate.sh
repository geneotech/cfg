if [[ $TERM -eq "linux" ]]
then
	terminator -e "source ~/.config/ranger/open_editor.sh $1" &!
else
	source ~/.config/ranger/open_editor.sh $1
fi
