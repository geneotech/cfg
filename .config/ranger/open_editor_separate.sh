if [[ "${TERM}" == "linux" ]]
then
	# echo "Term is ${TERM}. Opening $1 in separate $TERMINAL" >> $HOME/termlog.txt

	$VISUAL "$@"
	#export NEWCMD="$EDITOR $1"; $TERMINAL > /dev/null
else
	# echo "Term is ${TERM}. Opening $1 in place." >> $HOME/termlog.txt

	$VISUAL "$@"
	# $EDITOR $1
fi
