if [[ $TERM -eq "linux" ]]
then
	export NEWCMD="$EDITOR $1"; $TERMINAL > /dev/null
else
	$EDITOR $1
fi
