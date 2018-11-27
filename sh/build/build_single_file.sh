. ~/cfg/sh/build/vim_builders.sh

build_and_run_file() {
	COMPILER_COMMANDS_SCRIPT=$1
	OUT_TERM=$2
	TARGET_EXECUTABLE=$3
	shift
	shift
	shift
	EXE_ARGUMENTS=$@

	wipe_all_logs

	rm -f $TARGET_EXECUTABLE

	COMPILER_COMMANDS="source $COMPILER_COMMANDS_SCRIPT"
	script -q -c $COMPILER_COMMANDS $INTERMEDIATE_LOG > $OUT_TERM

	strip_timing_info_logs
	send_errors_to_vim_if_any

	if [ -f $TARGET_EXECUTABLE ]; then
		echo "Executable found: $TARGET_EXECUTABLE"
		echo "Runnning with: $EXE_ARGUMENTS"

		script -q -c "$TARGET_EXECUTABLE $EXE_ARGUMENTS" $RUN_RESULT_PATH > $OUT_TERM
		cut_n_lines 1 $RUN_RESULT_PATH
	else
		echo "Executable not found."
	fi
}

build_file() {
	COMPILER_COMMANDS_SCRIPT=$1
	TARGET_EXECUTABLE=$2

	wipe_all_logs

	rm -f $TARGET_EXECUTABLE

	COMPILER_COMMANDS="source $COMPILER_COMMANDS_SCRIPT"
	script -q -c $COMPILER_COMMANDS $INTERMEDIATE_LOG > $OUTPUT_TERM

	strip_timing_info_logs
	send_errors_to_vim_if_any
}
