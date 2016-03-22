#!/bin/bash
infile=$1 # index.js
globalvar=$2 # doSomething
outfile=$3 # do-something

tasksDir="$(dirname "$(which "$0")")"
export PATH=$tasksDir:$tasksDir/../node_modules/.bin:$PATH

mkdir -p dist
build-for-browser.sh $infile $globalvar | minify.sh $outfile
build-for-node.sh $infile $outfile | minify.sh ${outfile}.node
