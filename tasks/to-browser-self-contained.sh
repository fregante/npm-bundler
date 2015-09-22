#!/bin/bash
current="$(dirname "$(which "$0")")"
export PATH=$current/../node_modules/.bin:$PATH

browserify $1 -t babelify | tee dist/$2.js
