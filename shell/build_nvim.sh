mkdir .deps ; cd .deps
cmake -DCMAKE_BUILD_TYPE=Release ../third-party -G Ninja
ninja
export CFLAGS='-O3 -flto -fuse-ld=lld'
export CXXFLAGS='-O3 -flto -fwhole-program-vtables -fuse-ld=lld'
export LDFLAGS='-flto -fwhole-program-vtables -fuse-ld=lld'
../
mkdir build ; cd build
cmake -DCMAKE_BUILD_TYPE=Release .. -G Ninja
ninja
sudo ninja install

