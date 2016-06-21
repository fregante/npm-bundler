#!/bin/bash

# Usage for node/browserify
# build.sh module-name

# Usage for node/browserify AND browser, with a global
# build.sh module-name moduleName

output_filename=$1 # used for: module-name.js
global_var=$2 # used for: window.moduleName

cjs_name=.common-js
es6_name=.es-modules
iife_name=.browser

if [[ $global_var = '--byte-count' ]]; then
	global_var=bytes
	iife_name=.byte-count
fi

function realpath {
	local r=$1
	local t=$(readlink "$r")
	while [ "$t" ]; do
		r=$(cd "$(dirname "$r")" && cd "$(dirname "$t")" && pwd -P)/"$(basename "$t")"
		t=$(readlink "$r")
	done
	echo "$r"
}

node_modules=$(dirname "$(realpath "$0")")/node_modules

echo $node_modules

mkdir -p dist

rollup \
	--config "$node_modules"/rollup-config-buble/index.js \
	--format es6 \
	--input index.js \
	--output dist/"$output_filename""$es6_name".js

rollup \
	--config "$node_modules"/rollup-config-buble/index.js \
	--format cjs \
	--input index.js \
	--output dist/"$output_filename""$cjs_name".js

if [[ $global_var ]]; then
	# with IIFE
	rollup \
		--config "$node_modules"/rollup-config-es6-browser/index.js \
		--name "$global_var" \
		--input index.js \
		--output dist/"$output_filename""$iife_name".js
fi
