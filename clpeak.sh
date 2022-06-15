#!/bin/bash
#zepeak setup
yes | apt-get update --fix-missing
yes | apt-get update
yes | apt --fix-broken install

user=sysgfxe2eval
passwd="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"
git clone https://github.com/krrishnarraj/clpeak.git

cd clpeak && git submodule update --init --recursive --remote && mkdir build && cd build && cmake .. && cmake --build .
./clpeak
