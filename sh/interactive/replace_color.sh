replace_color() {
	target_file=$1
	source_col=$2
	target_col=$3

	shift

	mkdir replacement_result
	copied_file=replacement_result/$target_file
	cp $target_file $copied_file
	target_file=$copied_file

	while (( $# >= 2 )); do
		source_col=$1
		target_col=$2
		echo "$source_col -> $target_col"
		convert $target_file -fuzz 0% -fill "$target_col" -opaque "$source_col" $target_file
		shift 2
	done
}
