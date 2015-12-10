# bfred-npm-bundler 

> Browserify, babelify, minify node modules. For my own modules, but maybe you can find it useful too.

## Usage

```sh
npm install --save-dev bfred-npm-bundler
```

Add to your module's `package.json`:

```json
"scripts": {
  "build": "./node_modules/bfred-npm-bundler/tasks/all.sh index.js doSomething do-something",
  "to-npm": "./node_modules/bfred-npm-bundler/tasks/to-npm.sh index.js do-something",
  "prepublish": "npm run to-npm"
}
```

where `doSomething` is the global variable name of the module (camelCase) and `do-something` is the module name on npm. Use the `*-self-contained` versions if you don't need a global.

## Files

Here's an explanation of the files that this generates (the ones in `dist/`)

* `index.js`: source file, in ES6, the input
* `dist/do-something.min.js`: browser-ready file with AMD or a global variable called `doSomething`
* `dist/do-something.node.js`: used by node/browserify with `require('do-something')`
* `dist/do-something.node.min.js`: same as above, but minified, for byte counting only

## License

MIT © [Federico Brigante](http://twitter.com/bfred_it)
