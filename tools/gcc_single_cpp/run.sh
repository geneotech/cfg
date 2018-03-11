. ~/cfg/shell/vim_builders.sh

rm $BT_PATH

rmlogs
rm $RUN_RESULT_PATH

if [[ "$MAKE_TARGET" = "run" ]]; then
	echo "Run-type target." > $OUTPUT_TERM
	rm core
fi

if [ -f ./main ]; then
	rm ./main
fi

GCC_COMMAND='g++ -std=gnu++1z -o ./main $(readlink -f ./main.cpp) -lstdc++fs -lpthread;'

script -q -c $GCC_COMMAND $LASTERR_PATH > $OUTPUT_TERM

if [ -f ./main ]; then
	script -q -c ./main $LASTERR_PATH > $OUTPUT_TERM
fi

# Remove timing info line

head -n -2 $LASTERR_PATH > /tmp/dobrazaraz
cp /tmp/dobrazaraz $LASTERR_PATH

ERRORS=$(ag "error:" $LASTERR_PATH)
LINKER_ERRORS=$(ag "error: ld" $LASTERR_PATH)

if [[ ! -z $ERRORS && -z $LINKER_ERRORS ]]
then
	cp $LASTERR_PATH $LASTERR_PATH_COLOR
	clnerr
	$(i3-msg "[title=NVIM] focus")
else
	cp $LASTERR_PATH $RUN_RESULT_PATH 
	sed -i '1d' $RUN_RESULT_PATH
	rmlogs
fi
