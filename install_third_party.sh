#!/bin/bash
set -e

# TODO: Make sure we have the following:
# - g++-4.x
# - boost, blat (for AMOS)

cd third_party

cd yaggo
make DEST=/usr/local/bin
cd ..

cd Jellyfish
autoreconf -i
mkdir -p build
cd build
CC=gcc-4.9 CXX=g++-4.9 ../configure --prefix=/usr/local
make
make install
cd ..
cd ..

cd amos
CC=gcc-4.9 CXX=g++-4.9 ./configure --prefix=/usr/local/pacbio --with-Boost-dir=/usr/local/include
make
make install
cd ..

cd wgs-assembler
cd kmer
CC=gcc-4.9 CXX=g++-4.9 ./configure.sh
make
make install
cd ..
cd samtools
make
cd ..
cd src
make
cd ..
cp -rf Darwin-amd64/bin /usr/local/pacbio/
cd ..
