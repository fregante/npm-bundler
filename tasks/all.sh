#!/bin/bash
infile=$1 # index.js
globalvar=$2 # doSomething
outfile=$3 # do-something

current="$(dirname "$(which "$0")")"
export PATH=$current:$current/../node_modules/.bin:$PATH

mkdir -p dist
to-browser.sh $infile $globalvar $outfile | minify.sh $outfile
to-node.sh $infile $outfile | minify.sh ${outfile}.node
