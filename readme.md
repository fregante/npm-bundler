# bfred-npm-bundler 

> Opinionated ES6 library bundler based on [rollup](https://github.com/rollup/rollup) and [buble](https://gitlab.com/Rich-Harris/buble)

It's for my own modules, but maybe you can find it useful too. It changes often (but follows semver). Unannounced PRs generally not welcome, but feel free to open issues to discuss first.

It outputs the following files:

* **dist/[lib-name].browser.js**  
	A minified file for the browser with a global called `[libName]`
* **dist/[lib-name].common-js.js**  
	A file to be used with browserify or similar. Set it up with:  
	`"main": "dist/[lib-name].common-js.js",` in package.json
* **dist/[lib-name].es-modules.js**  
	A file to be used with ESM-aware bundlers like rollup. Set it up with:  
	`"jsnext:main": "dist/[lib-name].es-modules.js",` in package.json

## Usage

Install it in your project:

```sh
npm install --save-dev bfred-npm-bundler 
```

Add the references to the generated files and the build step in your `package.json`:

```json
{
	"main": "dist/lib-name.common-js.js",
	"jsnext:main": "dist/lib-name.es-modules.js",
	"scripts": {
		"build": "bfred-npm-bundler lib-name libName",
		"prepublish": "npm run build"
	}
}
```

## Node-only

If your lib only makes sense inside node/browserify, you can skip the `browser` file creation by not passing the second argument:

`bfred-npm-bundler lib-name` instead of `bfred-npm-bundler lib-name libName`

## Byte-counting

The `browser` file is useful to be used for byte-counting via [`gzip-size-cli`](https://github.com/sindresorhus/gzip-size-cli) or with [badges.](https://github.com/exogen/badge-matrix#file-size-badges-for-any-file-on-github-or-npm) If your package is _node-only,_ you can pass the option `--byte-count` and a **dist/[lib-name].byte-count.js** file will be created.

## Alternatives

[rollup-babel-lib-bundler](https://github.com/frostney/rollup-babel-lib-bundler) is more configurable

## License

MIT © [Federico Brigante](http://twitter.com/bfred_it)
