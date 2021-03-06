. ~/cfg/sh/open/workspace/current
. ~/cfg/sh/build/log_paths.sh 
. /tmp/viewing_tty

export WORKSPACE_NAME=$(basename $WORKSPACE)
export WORKSPACE_EXE=$WORKSPACE/build/current/$WORKSPACE_NAME

export INTERMEDIATE_LOG="/tmp/intermediate_log.txt"
export TEMP_PATH="/tmp/temp.txt"

# Handy building aliases
alias interrupt='pkill -f --signal 2 '

gdbtarget() {
	if [ -f $WORKSPACE_EXE ]; then
		TARGET_EXECUTABLE=$WORKSPACE_EXE
	fi

	gdb $TARGET_EXECUTABLE
}

lldbtarget() {
	if [ -f $WORKSPACE_EXE ]; then
		TARGET_EXECUTABLE=$WORKSPACE_EXE
	fi

	lldb $TARGET_EXECUTABLE
}

gdbcore() {
	if [ -f $WORKSPACE_EXE ]; then
		TARGET_EXECUTABLE=$WORKSPACE_EXE
	fi

	gdb $TARGET_EXECUTABLE $WORKSPACE/hypersomnia/core
}

hcore() {
	if [ -f $WORKSPACE_EXE ]; then
		TARGET_EXECUTABLE=$WORKSPACE_EXE
	fi

	#gdb -ex="set logging file bt.txt" -ex="set logging on" -ex="bt" -ex="q" $WORKSPACE_EXE $WORKSPACE/hypersomnia/core
	cd $WORKSPACE
	gdb -ex="bt" -ex="q" $TARGET_EXECUTABLE $WORKSPACE/hypersomnia/core
}

cut_n_lines () {
	sed -i -e "1,$1d" $2
}

wipe_all_logs() {
	rm -f $INTERMEDIATE_LOG
	rm -f $BUILD_SUCCESS_PATH

	rm -f $LASTERR_PATH
	rm -f $LASTERR_PATH_COLOR

	rm -f $RUN_RESULT_PATH

	rm -f $BT_PATH
}

strip_color_codes() {
	sed -i -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' $1
	sed -i -r 's/\x1B\[0;1;3[1-2]m//g' $1
	sed -i 's/\r$//g' $1
	sed -i -e '1d' $1
}

strip_timing_info_logs() {
	head -n -2 $INTERMEDIATE_LOG > $TEMP_PATH
	cp $TEMP_PATH $INTERMEDIATE_LOG
}

wipe_all_cores() {
	rm -f core
	rm -f hypersomnia/core
}

make_with_logs() {
	MAKE_TARGET=$1
	TARGET_DIR=$2

	wipe_all_logs

	if [ "$MAKE_TARGET" = "run" ]; then
		echo "Run-type target." > $OUTPUT_TERM
		wipe_all_cores
	fi

	script -q -c "time ninja $MAKE_TARGET -C $TARGET_DIR" $INTERMEDIATE_LOG > $OUTPUT_TERM

	strip_timing_info_logs

	if [ "$MAKE_TARGET" = "run" ]; then
		echo "Run-type target." > $OUTPUT_TERM
		if [ -f hypersomnia/core ]; then
			echo "Core found." > $OUTPUT_TERM
			hcore | tee $OUTPUT_TERM $BT_PATH

			# This line is necessary for vim to parse the relative paths to sources correctly.
			echo "ninja: Entering directory '$TARGET_DIR'" > $TEMP_PATH

			perl ~/cfg/sh/build/bt2ll.pl < $BT_PATH >> $TEMP_PATH
			cp $TEMP_PATH $BT_PATH
			$(i3-msg "[title=NVIM] focus")
		fi
	fi
}

make_current() {
	MAKE_TARGET=$1

	make_with_logs $MAKE_TARGET build/current
}

send_errors_to_vim_if_any() {
	# We need to be more specific about "error" string,
	# because it may turn out that the game itself has emitted some "error:" messages,
	# but we do not want NVIM to handle this.
	cp $INTERMEDIATE_LOG $TEMP_PATH
	strip_color_codes $TEMP_PATH

	ERRORS=$(ag ": error:" $TEMP_PATH)
	FATAL_ERRORS=$(ag ": fatal error:" $TEMP_PATH)
	
	if [ ! -z $ERRORS ] || [ ! -z $FATAL_ERRORS ] ; then
		mv $TEMP_PATH $LASTERR_PATH
		mv $INTERMEDIATE_LOG $LASTERR_PATH_COLOR

		if [ "$1" = "silent" ]; then
			exit 0
		fi
	else
		echo "." > $BUILD_SUCCESS_PATH
	fi
}

focus_vim() {
	$(i3-msg "[title=NVIM] focus")
}

focus_ue4() {
	$(i3-msg "[title=\"$WORKSPACE_NAME - Unreal Editor\"] focus")
}

vim_target() {
	interrupt ninja
	cd $WORKSPACE

	make_current $1
	send_errors_to_vim_if_any $2
	focus_vim
}

vim_ue4_target() {
	interrupt ue4build
	cd $WORKSPACE

	wipe_all_logs
	script -q -c "time ue4build $WORKSPACE/$WORKSPACE_NAME.uproject" $INTERMEDIATE_LOG > $OUTPUT_TERM

	send_errors_to_vim_if_any $2

	if [ ! -z $ERRORS ] ; then
		focus_vim
	else
		focus_ue4
	fi
}

vim_build() {
	vim_target all
}

vim_run() {
	vim_target run
}
