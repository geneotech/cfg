WORKSPACES="
/home/pbc/Hypersomnia
/home/pbc/Hypersomnia/docs
/home/pbc/cfg
/home/pbc/documentation-theme-jekyll
/home/pbc/cfg/x11_xcb_example"

NEW_WORKSPACE=$(echo $WORKSPACES | sed 1d | rofi -hide-scrollbar -dmenu -i -p 'select workspace:')

echo "export WORKSPACE=$NEW_WORKSPACE" > ~/.config/i3/workspace/current
