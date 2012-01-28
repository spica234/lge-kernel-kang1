#!/bin/sh

#standard version
./initialize.sh
./compile.sh 0
#32m shared
./initialize.sh
./compile.sh 32 shared
#32m
./initialize.sh
./compile.sh 32
#48m
./initialize.sh
./compile.sh 48
#64m
./initialize.sh
./compile.sh 64
#80m
./initialize.sh
./compile.sh 80
#96m
./initialize.sh
./compile.sh 96
