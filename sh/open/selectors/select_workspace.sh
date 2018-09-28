WORKSPACES="
$HOME/Hypersomnia
$HOME/cfg
$HOME/rep/rectpack2D
$HOME/cfg/maincpp"

. ~/cfg/sh/open/workspace/current

NEW_WORKSPACE=$(echo $WORKSPACES | sed 1d | rofi -hide-scrollbar -dmenu -i -p "change $WORKSPACE to")

if [[ ! -z $NEW_WORKSPACE ]]
then
	echo "export WORKSPACE=$NEW_WORKSPACE" > ~/cfg/sh/open/workspace/current
fi
