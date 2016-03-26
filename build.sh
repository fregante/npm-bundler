#!/bin/bash

# Usage for node/browserify
# build.sh module-name

# Usage for node/browserify AND browser, with a global
# build.sh module-name moduleName

output_filename=$1 # used for: module-name.js
global_var=$2 # used for: window.moduleName

if [[ $global_var ]]; then
	# with IIFE
	rollup-babel-lib-bundler \
		--lib-name "$output_filename" \
		--format cjs,es6,iife \
		--module-name "$global_var" \
		--dest dist index.js

	# only mangle names inside the IIFE
	uglifyjs \
		--mangle -- \
		dist/"$output_filename".iife.js > dist/"$output_filename".browser.js

	## delete the non-minified version
	rm dist/"$output_filename".iife.js
else
	# no IIFE
	rollup-babel-lib-bundler \
		--lib-name "$output_filename" \
		--format cjs,es6 \
		--dest dist index.js
fi

# clearer naming
mv dist/"$output_filename".js dist/"$output_filename".common-js.js
mv dist/"$output_filename".es2015.js dist/"$output_filename".es-modules.js