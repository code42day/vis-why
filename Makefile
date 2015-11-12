NODE_BIN=./node_modules/.bin
PROJECT=vis-why

all: check build

check: lint test

lint: node_modules
	$(NODE_BIN)/jshint index.js test

test: node_modules
	$(NODE_BIN)/mocha --require should test

build: build/build.js

build/build.js: node_modules index.js
	mkdir -p build
	browserify --require ./index.js:$(PROJECT) --outfile $@

node_modules: package.json
	npm install

clean:
	rm -fr build

distclean: clean
	rm -fr node_modules

.PHONY: clean distclean lint check all build
