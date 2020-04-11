#!/bin/bash

here=$(realpath $(dirname $0))
cd $here

raylib_dir=$(realpath ../external/raylib)

echo "compiling"
gcc main.c -o main -L$raylib_dir/lib -I$raylib_dir/include -lraylib

echo "running"
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$raylib_dir/lib ./main | tee ./out
