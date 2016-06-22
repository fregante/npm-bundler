#!/usr/bin/env node
'use strict';
const rollup = require('rollup').rollup;
const buble = require('rollup-plugin-buble');
const uglify = require('rollup-plugin-uglify');

const outputFilename = process.argv[2];
let globalVarName = process.argv[3];

let cjsName = 'common-js';
let esName = 'es-modules';
let iifeName = 'browser';

if (globalVarName === '--byte-count') {
	globalVarName = 'bytes';
	iifeName = 'byte-count';
}

cjsName = `dist/${outputFilename}.${cjsName}.js`;
esName = `dist/${outputFilename}.${esName}.js`;
iifeName = `dist/${outputFilename}.${iifeName}.js`;

console.log('Files built:');
rollup({
	entry: 'index.js',
	plugins: [
		buble()
	]
}).then(bundle => Promise.all([
	bundle.write({
		format: 'cjs',
		dest: cjsName
	}).then(() => console.log('•', cjsName)),
	bundle.write({
		format: 'es',
		dest: esName
	}).then(() => console.log('•', esName))
])).catch(err => console.log(err));
if (globalVarName) {
	rollup({
		entry: 'index.js',
		plugins: [
			buble(),
			uglify()
		]
	}).then(bundle =>
		bundle.write({
			format: 'iife',
			moduleName: globalVarName,
			dest: iifeName
		}).then(() => console.log('•', iifeName))
	).catch(err => console.log(err));
}
