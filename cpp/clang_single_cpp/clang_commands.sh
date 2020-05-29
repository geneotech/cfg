MAIN_PATH=$(readlink -f ./main.cpp)

echo "Init pass."
clang++ -Wall -stdlib=libc++ -std=gnu++1z -O3 -pthread -o main.cpp.o -c $MAIN_PATH 
echo "Link pass."
clang++ -Wall -stdlib=libc++ -std=gnu++1z -O3 -pthread -fuse-ld=lld main.cpp.o -o ./main 
