if [[ "${TERM}" == "linux" ]]
then
	# echo "Term is ${TERM}. Opening $1 in separate $TERMINAL" >> /home/pbc/termlog.txt

	$VISUAL $1
	#export NEWCMD="$EDITOR $1"; $TERMINAL > /dev/null
else
	# echo "Term is ${TERM}. Opening $1 in place." >> /home/pbc/termlog.txt

	$EDITOR $1
fi
