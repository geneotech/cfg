WORKSPACES="
/home/pbc/Hypersomnia
/home/pbc/cfg
/home/pbc/cfg/maincpp"

#/home/pbc/Hypersomnia
#/home/pbc/Hypersomnia/docs
#/home/pbc/cfg
#/home/pbc/documentation-theme-jekyll
#/home/pbc/cfg/x11_xcb_example

source ~/.config/i3/workspace/current

NEW_WORKSPACE=$(echo $WORKSPACES | sed 1d | rofi -hide-scrollbar -dmenu -i -p "change $WORKSPACE to")

if [[ ! -z $NEW_WORKSPACE ]]
then
	echo "export WORKSPACE=$NEW_WORKSPACE" > ~/.config/i3/workspace/current
	source ~/cfg/.config/i3/workspace/bind_workspace_editor.sh
fi
