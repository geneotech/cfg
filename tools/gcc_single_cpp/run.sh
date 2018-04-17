. ~/cfg/shell/vim_builders.sh

wipe_all_logs

rm -f ./main

GCC_COMMAND='g++ -std=gnu++1z -o ./main $(readlink -f ./main.cpp) -lstdc++fs -lpthread;'

script -q -c $GCC_COMMAND $INTERMEDIATE_LOG > $OUTPUT_TERM

strip_timing_info_logs
send_errors_to_vim_if_any

if [ -f ./main ]; then
	echo "Build successful."

	script -q -c ./main $RUN_RESULT_PATH > $OUTPUT_TERM
	cut_n_lines 1 $RUN_RESULT_PATH
else
	echo "Executable not found."
fi
