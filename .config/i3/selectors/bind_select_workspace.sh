WORKSPACES="
/home/pbc/Hypersomnia
/home/pbc/cfg
/home/pbc/cfg/maincpp"

. ~/.config/i3/workspace/current

NEW_WORKSPACE=$(echo $WORKSPACES | sed 1d | rofi -hide-scrollbar -dmenu -i -p "change $WORKSPACE to")

if [[ ! -z $NEW_WORKSPACE ]]
then
	echo "export WORKSPACE=$NEW_WORKSPACE" > ~/.config/i3/workspace/current
fi
