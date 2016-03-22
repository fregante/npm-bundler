#!/bin/bash
# Wrap module in a UMD ES5 bundle

moduleDir=$PWD
tasksDir=${0%/*}

mkdir -p dist
cd $tasksDir
rollup -c --format umd --name $2 ${moduleDir}/$1 | babel
