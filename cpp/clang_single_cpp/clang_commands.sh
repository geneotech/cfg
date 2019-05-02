MAIN_PATH=$(readlink -f ./main.c)

echo "Init pass."
clang -O3 -pthread -o main.c.o -c $MAIN_PATH 
echo "Link pass."
clang -O3 -pthread -fuse-ld=lld main.c.o -o ./main 
