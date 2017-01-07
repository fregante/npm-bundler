#!/usr/bin/env node
'use strict';
const rollup = require('rollup').rollup;
const buble = require('rollup-plugin-buble');
const uglify = require('rollup-plugin-uglify');
const requireExternals = require('rollup-plugin-node-resolve');
const filesize = require('rollup-plugin-filesize');
const readPkg = require('read-pkg').sync;

const packageInfo = readPkg();
const banner = `/*! npm.im/${packageInfo.name} */`;

const outputFilename = process.argv[2];
let globalVarName = process.argv[3];

const iifeName = `dist/${outputFilename}.js`;
const cjsName = `dist/${outputFilename}.common-js.js`;
const esName = `dist/${outputFilename}.es-modules.js`;
let minName = `dist/${outputFilename}.min.js`;

const isByteCountingOnly = globalVarName === '--byte-count';
if (isByteCountingOnly) {
	globalVarName = 'bytes';
	minName = 'dist/size-measuring-only';
}

console.log('Building:');
if (globalVarName) {
	console.log('•', iifeName);
	rollup({
		entry: 'index.js',
		plugins: [
			buble(),
			requireExternals({
				browser: true,
				jsnext: true
			})
		]
	}).then(bundle =>
		bundle.write({
			format: 'iife',
			moduleName: globalVarName,
			dest: iifeName,
			banner
		})
	).catch(console.error);

	console.log('•', minName);
	rollup({
		entry: 'index.js',
		plugins: [
			buble(),
			requireExternals({
				browser: true,
				jsnext: true
			}),
			uglify(),
			filesize({
				format: {
					exponent: 0
				}
			})
		]
	}).then(bundle =>
		bundle.write({
			format: 'iife',
			moduleName: globalVarName,
			dest: minName,
			banner
		})
	).catch(console.error);
}

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
])).catch(console.error);
