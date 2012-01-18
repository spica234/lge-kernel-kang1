#!/bin/sh

# compile the standard version
./initialize.sh vadonka_defconfig
./compile.sh 0
./initialize.sh vadonka_defconfig
./compile.sh 32 shared
./initialize.sh vadonka_defconfig
./compile.sh 32
./initialize.sh vadonka_defconfig
./compile.sh 64

# compile the powersave version
./initialize.sh vadonka_pwrs_defconfig
./compile.sh 0
./initialize.sh vadonka_pwrs_defconfig
./compile.sh 32 shared
./initialize.sh vadonka_pwrs_defconfig
./compile.sh 32
./initialize.sh vadonka_pwrs_defconfig
./compile.sh 64
