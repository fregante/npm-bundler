#!/bin/bash
infile=$1 # index.js
outfile=$2 # do-something

current="$(dirname "$(which "$0")")"
export PATH=$current:$current/../node_modules/.bin:$PATH

mkdir -p dist
to-node.sh $infile $outfile > /dev/null
