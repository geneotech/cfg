WORKSPACES="
/home/pbc/Hypersomnia
/home/pbc/cfg
/home/pbc/cfg/x11_xcb_example"

echo $WORKSPACES
NEW_WORKSPACE=$(echo $WORKSPACES | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'select workspace:')
echo $NEW_WORKSPACE
echo "export WORKSPACE=$NEW_WORKSPACE" > ~/.config/i3/workspace/current
