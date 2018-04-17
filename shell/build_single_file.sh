. ~/cfg/shell/vim_builders.sh

build_single_file() {
	TARGET_EXECUTABLE=$1
	COMPILER_COMMANDS_SCRIPT=$2

	wipe_all_logs

	rm -f $TARGET_EXECUTABLE

	COMPILER_COMMANDS="source $COMPILER_COMMANDS_SCRIPT"
	script -q -c $COMPILER_COMMANDS $INTERMEDIATE_LOG > $OUTPUT_TERM

	strip_timing_info_logs
	send_errors_to_vim_if_any

	if [ -f $TARGET_EXECUTABLE ]; then
		echo "Build successful."

		script -q -c $TARGET_EXECUTABLE $RUN_RESULT_PATH > $OUTPUT_TERM
		cut_n_lines 1 $RUN_RESULT_PATH
	else
		echo "Executable not found."
	fi
}
