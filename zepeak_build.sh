git clone  https://github.com/oneapi-src/level-zero.git
cd level-zero
mkdir build
cd build
cmake ..
pid=$!
wait $pid
cmake --build . --config Release
pid=$!
wait $pid
cmake --build . --config Release --target package
pid=$!
wait $pid
cmake --build . --config Release --target install
pid=$!
wait $pid

apt install -y -f libpng-dev libboost-all-dev swig
 
git clone  https://github.com/oneapi-src/level-zero-tests.git
cd level-zero-tests
mkdir build;cd build
cmake -D GROUP=/perf_tests -D CMAKE_INSTALL_PREFIX=$PWD/../out/perf_tests -D ENABLE_ZESYSMAN="yes" ..
pid=$!
wait $pid

cmake --build . --config Release --target install

cd /home/gta/level-zero/build/level-zero-tests/perf_tests

echo "Zepeak Build Done. Run your tests"
