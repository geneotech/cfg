MAIN_PATH=$(readlink -f ./main.cpp)
g++ -std=gnu++1z -O3 -o ./main $MAIN_PATH -lstdc++fs -lpthread;
