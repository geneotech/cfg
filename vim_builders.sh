source ~/.config/i3/workspace/current

export WORKSPACE_NAME=$(basename $WORKSPACE)
export WORKSPACE_EXE=$WORKSPACE/build/current/$WORKSPACE_NAME
export OUTPUT_TERM=/dev/pts/1

function gdbcore() {
	if [ -f $WORKSPACE_EXE ]; then
		TARGET_EXECUTABLE=$WORKSPACE_EXE
	fi

	gdb $TARGET_EXECUTABLE $WORKSPACE/hypersomnia/core
}

function hcore() {
	if [ -f $WORKSPACE_EXE ]; then
		TARGET_EXECUTABLE=$WORKSPACE_EXE
	fi

	#gdb -ex="set logging file bt.txt" -ex="set logging on" -ex="bt" -ex="q" $WORKSPACE_EXE $WORKSPACE/hypersomnia/core
	cd $WORKSPACE
	gdb -ex="bt" -ex="q" $TARGET_EXECUTABLE $WORKSPACE/hypersomnia/core
}

alias interrupt='pkill -f --signal 2 '

export LASTERR_PATH=/tmp/last_error.txt
export LASTERR_PATH_COLOR=/tmp/last_error_color.txt
export RUN_RESULT_PATH=/tmp/run_result.txt
export BT_PATH=/tmp/bt.txt

function rmlogs() {
	rm $LASTERR_PATH
	rm $LASTERR_PATH_COLOR
}

function stripcodes() {
	sed -i -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' $1
	sed -i 's/\r$//g' $1
	sed -i -e '1d' $1
}

# Handy building aliases
alias clnerr='stripcodes $LASTERR_PATH'

function make_with_logs() {
	MAKE_TARGET=$1
	TARGET_DIR=$2

	rmlogs

	if [[ "$MAKE_TARGET" = "run" ]]; then
		echo "Run-type target." > $OUTPUT_TERM
		rm hypersomnia/core
		rm $BT_PATH
	fi

	script -q -c "time make $MAKE_TARGET -j8 -C $TARGET_DIR" $LASTERR_PATH > $OUTPUT_TERM

	# Remove timing info line
	head -n -2 $LASTERR_PATH > /tmp/dobrazaraz
	cp /tmp/dobrazaraz $LASTERR_PATH

	if [[ "$MAKE_TARGET" = "run" ]]; then
		echo "Run-type target." > $OUTPUT_TERM
		if [ -f hypersomnia/core ]; then
			echo "Core found." > $OUTPUT_TERM
			hcore | tee /dev/pts/1 $BT_PATH
			perl ~/cfg/tools/bt2ll.pl < $BT_PATH > /tmp/dobrazaraz
			cp /tmp/dobrazaraz $BT_PATH
			$(i3-msg "[title=NVIM] focus")
		fi
	fi
}

function make_current() {
	MAKE_TARGET=$1

	make_with_logs $MAKE_TARGET build/current
}

function handle_last_errors() {
	ERRORS=$(ag "error:" $LASTERR_PATH)
	LINKER_ERRORS=$(ag "error: ld" $LASTERR_PATH)
	
	if [[ ! -z $ERRORS && -z $LINKER_ERRORS ]]
	then
		cp $LASTERR_PATH $LASTERR_PATH_COLOR
		clnerr
		$(i3-msg "[title=NVIM] focus")
	else
		rmlogs
	fi
}

function vim_target() {
	interrupt make
	cd $WORKSPACE
	make_current $1
	handle_last_errors
}

function vim_build() {
	vim_target all
}

function vim_debug() {
	vim_target conque_debug
}

function vim_run() {
	vim_target run
}
