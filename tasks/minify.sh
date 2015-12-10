#!/bin/bash
uglifyjs --mangle < /dev/stdin > dist/$1.min.js
