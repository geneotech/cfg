WORKSPACES="
$HOME/avm
$HOME/hurry_heroes
$HOME/testgodot
$HOME/blackops
$HOME/page
$HOME/Avio
$HOME/rep/industry-4.0
$HOME/beautyfactory_v2
$HOME/rep/slapper
$HOME/bf
$HOME/opi
$HOME/kivy
$HOME/Hypersomnia
$HOME/cfg
$HOME/cfg/cpp/ocv
"

. ~/cfg/sh/open/workspace/current

NEW_WORKSPACE=$(echo $WORKSPACES | sed 1d | rofi -hide-scrollbar -dmenu -i -p "change $WORKSPACE to")

if [[ ! -z $NEW_WORKSPACE ]]
then
	echo "export WORKSPACE=$NEW_WORKSPACE" > ~/cfg/sh/open/workspace/current
fi
