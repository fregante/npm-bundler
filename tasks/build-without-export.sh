#!/bin/bash
infile=$1 # index.js
outfile=$2 # do-something

tasksDir="$(dirname "$(which "$0")")"
export PATH=$tasksDir:$tasksDir/../node_modules/.bin:$PATH

mkdir -p dist
build-for-browser-without-export.sh $infile | minify.sh $outfile
build-for-node.sh $infile $outfile | minify.sh ${outfile}.node
