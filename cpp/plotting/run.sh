. ~/cfg/sh/build/build_single_file.sh

TARGET_EXECUTABLE=./main
build_file $TARGET_EXECUTABLE ./clang_commands.sh

if [ -f $TARGET_EXECUTABLE ]; then
	$TARGET_EXECUTABLE > points.txt

	echo "Exe found and ran. " > $RUN_RESULT_PATH

	./plot.py > $OUTPUT_TERM
else
	echo "Exe not found" > $RUN_RESULT_PATH
fi
