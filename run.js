#!/usr/bin/env node
/**
 * process.argv = [ '/usr/local/bin/node',
  '/Users/bfred/Web/projects-modules/inline-player/node_modules/.bin/bundler-build' ]
 */
var spawn   = require('child_process').spawn;
var path    = require('path');
var args    = process.argv.slice(2);
var cmdName = process.argv[1]
	.split(path.sep)
	.pop()
	.replace('bundler-', __dirname+path.sep+'tasks'+path.sep) + '.sh';

var cmd = spawn(cmdName, args);

cmd.stdout.on('data', function (data) { process.stdout.write(data); });
cmd.stderr.on('data', function (data) { process.stderr.write(data); });
