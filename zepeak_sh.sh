#!/bin/bash
#zepeak setup
user=$(cat /root/gituser)
passwd=$(cat /root/gitpass)
 
git clone https://$user:$passwd@https://github.com/oneapi-src/level-zero.git
yes | apt-get install build-essential cmake  
cd level-zero
mkdir build && cd build
cmake ..
cmake --build . --config Release
cmake --build . --config Release --target package
cmake --build . --config Release --target install

apt install -y -f libpng-dev libboost-all-dev swig
git clone  https://github.com/oneapi-src/level-zero-tests.git
cd level-zero-tests
mkdir build;cd build
cmake -D GROUP=/perf_tests -D CMAKE_INSTALL_PREFIX=$PWD/../out/perf_tests -D ENABLE_ZESYSMAN="yes" ..
cmake --build . --config Release --target install
ze_peak_path=`pwd`
test_loc="/../out/perf_tests"
ze_peak_path+=$test_loc
cd $ze_peak_path
./ze_peak
