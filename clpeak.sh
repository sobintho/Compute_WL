#!/bin/bash
#zepeak setup
user=$(cat /root/gituser)
passwd=$(cat /root/gitpass)

yes | apt-get update --fix-missing
yes | apt-get update
yes | apt --fix-broken install

git clone https://github.com/krrishnarraj/clpeak.git

cd clpeak && git submodule update --init --recursive --remote && mkdir build && cd build && cmake .. && cmake --build .
./clpeak
