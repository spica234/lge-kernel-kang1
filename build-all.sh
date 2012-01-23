#!/bin/sh

./initialize.sh
./compile.sh 0
./initialize.sh
./compile.sh 32 shared
./initialize.sh
./compile.sh 32
./initialize.sh
./compile.sh 64
