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

if [[ $global_var ]]; then
	# with IIFE
	rollup-babel-lib-bundler \
		--lib-name "$output_filename" \
		--module-name "$global_var" \
		--format cjs,es6,iife \
		--postfix cjs:"$cjs_name",es6:"$es6_name" \
		--dest dist index.js

	# only mangle names inside the IIFE
	uglifyjs \
		--mangle -- \
		dist/"$output_filename".iife.js > dist/"$output_filename""$iife_name".js

	# delete the non-minified version
	rm dist/"$output_filename".iife.js
else
	# no IIFE
	rollup-babel-lib-bundler \
		--lib-name "$output_filename" \
		--format cjs,es6 \
		--postfix cjs:"$cjs_name",es6:"$es6_name" \
		--dest dist index.js
fi
