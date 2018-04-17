MAIN_PATH=$(readlink -f ./main.cpp)
g++ -std=gnu++1z -o ./main $MAIN_PATH -lstdc++fs -lpthread;
