#!/bin/bash
current="$(dirname "$(which "$0")")"
export PATH=$current/../node_modules/.bin:$PATH

babel $1 | tee dist/$2.node.js
