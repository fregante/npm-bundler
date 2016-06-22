#!/usr/bin/env node
'use strict';
const path = require('path');
const rollup = require('rollup').rollup;
const buble = require('rollup-plugin-buble');
const uglify = require('rollup-plugin-uglify');
const requireExternals = require('rollup-plugin-node-resolve');
const filesize = require('rollup-plugin-filesize');

const packageInfo = require(path.resolve('./package.json'));
const banner = `/*! npm.im/${packageInfo.name} */`;

const outputFilename = process.argv[2];
let globalVarName = process.argv[3];

let cjsName = 'common-js';
let esName = 'es-modules';
let iifeName = 'browser';

const isByteCountingOnly = globalVarName === '--byte-count';
if (isByteCountingOnly) {
	globalVarName = 'bytes';
	iifeName = 'byte-count';
}

cjsName = `dist/${outputFilename}.${cjsName}.js`;
esName = `dist/${outputFilename}.${esName}.js`;
iifeName = `dist/${outputFilename}.${iifeName}.js`;

console.log('Building:');
console.log('•', cjsName);
console.log('•', esName);
rollup({
	entry: 'index.js',
	plugins: [
		buble()
	]
}).then(bundle => Promise.all([
	bundle.write({
		format: 'cjs',
		dest: cjsName,
		banner
	}),
	bundle.write({
		format: 'es',
		dest: esName,
		banner
	})
])).catch(err => console.log(err));
if (globalVarName) {
	console.log('•', iifeName);
	rollup({
		entry: 'index.js',
		plugins: [
			buble(),
			requireExternals({
				browser: true,
				jsnext: true
			}),
			uglify(isByteCountingOnly ? {
				output: {
					comments: (node, comment) => {
						if (comment.type === 'comment2') {
							return comment.value[0] === '!';
						}
					}
				}
			} : {}),
			filesize()
		]
	}).then(bundle =>
		bundle.write({
			format: 'iife',
			moduleName: globalVarName,
			dest: iifeName,
			banner
		})
	).catch(err => console.log(err));
}
