#!/usr/bin/env zsh
. ~/cfg/sh/build/build_single_file.sh
build_and_run_file ./gcc_commands.sh $(tty) ./main $@
