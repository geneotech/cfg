#razercfg -r 3500

SEARCH=Razer
RAZER_SPEED=1.0

if [ "$SEARCH" = "" ]; then 
    exit 1
fi

ids=$(xinput --list | awk -v search="$SEARCH" \
    '$0 ~ search {match($0, /id=[0-9]+/);\
                  if (RSTART) \
                    print substr($0, RSTART+3, RLENGTH-3)\
                 }'\
     )

for i in $ids
do
    echo "DEVICE FOUND: ${i}"
    xinput set-prop $i "Coordinate Transformation Matrix" $RAZER_SPEED, 0, 0, 0, $RAZER_SPEED, 0, 0, 0, 1
    xinput set-prop $i "libinput Accel Profile Enabled" 0, 1
done

setxkbmap pl
xmodmap -e "clear lock"
xmodmap -e "keysym Caps_Lock = Escape"

~/cfg/sh/init_nvidia

exec i3

#export GDK_BACKEND=x11
#exec gnome-session
