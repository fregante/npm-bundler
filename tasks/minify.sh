#!/bin/bash
current="$(dirname "$(which "$0")")"
export PATH=$current/../node_modules/.bin:$PATH

uglifyjs --mangle < /dev/stdin > dist/$1.min.js
