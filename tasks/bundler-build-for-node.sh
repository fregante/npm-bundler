#!/bin/bash
# Convert module to ES5 for node/browserify usage

infile=$1 # index.js
outfile=$2 # do-something

mkdir -p dist
rollup --format cjs $infile | babel --presets es2015-rollup | tee dist/${outfile}.node.js
