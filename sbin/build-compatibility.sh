#!/bin/bash

here="$(realpath $(dirname $0))"
cd $here/..

function func_error {
    echo "$1" 2>&1
    exit 1
}

cmake -H./compatibility -B./external/compatibility || func_error "failed generating project"
cmake --build ./external/compatibility || func_error "build failed"
