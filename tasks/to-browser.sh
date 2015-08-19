#!/bin/bash
current="$(dirname "$(which "$0")")"
export PATH=$current/../node_modules/.bin:$PATH

browserify $1 --standalone $2 | tee dist/$3.js
