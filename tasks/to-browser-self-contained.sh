#!/bin/bash
# Wrap module in a ES5 bundle without exports/globals

moduleDir=$PWD
tasksDir=$PWD/${0%/*}

mkdir -p dist
cd $tasksDir
rollup -c --format iife ${moduleDir}/$1 | babel
