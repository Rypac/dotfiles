#!/bin/sh

cd ~/packages/cloned/i3-gaps

autoreconf --force --install
rm -rf build
mkdir -p build
cd build

../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install
