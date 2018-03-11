source ~/cfg/vim_builders.sh

echo "Clang build started." > $OUTPUT_TERM

if [ -f ./main.exe ]; then
	rm ./main.exe
fi

if [ -f ./main.cpp.o ]; then
	rm ./main.cpp.o
fi

echo "Init pass." > $OUTPUT_TERM
clang++ -v -stdlib=libc++ -std=gnu++1z -o main.cpp.o -c main.cpp 
echo "Link pass." > $OUTPUT_TERM
clang++ -v -stdlib=libc++ -fuse-ld=lld main.cpp.o -o ./main.exe -lc++experimental

if [ -f ./main.exe ]; then
	echo "Clang build successful." > $OUTPUT_TERM
	./main.exe > $OUTPUT_TERM
fi
