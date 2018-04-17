MAIN_PATH=$(readlink -f ./main.cpp)

echo "Init pass."
clang++ -v -stdlib=libc++ -std=gnu++1z -o main.cpp.o -c $MAIN_PATH 
echo "Link pass."
clang++ -v -stdlib=libc++ -fuse-ld=lld main.cpp.o -o ./main -lc++experimental
