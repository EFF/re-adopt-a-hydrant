MOCHA_REPORTER=list
TIMEOUT=10000

compile-javascript:
	./compile_coffee_to_javascript.sh &
	./compile_javascript_with_closure_compiler.sh

test-backend-unit:
	@NODE_ENV=test \
	./node_modules/.bin/mocha \
		--recursive \
		--reporter $(MOCHA_REPORTER) \
		--timeout $(TIMEOUT) \
		--bail \
		--invert \
		./tests/backend-unit/*.test.coffee \
		--require coffee-script

test-karma-e2e:
	./node_modules/karma/bin/karma start tests/config/karma.conf.e2e.js

test-karma-e2e-travis-ci:
	foreman start web -p 5060 < /dev/null &
	./node_modules/karma/bin/karma start tests/config/karma.conf.e2e.js --single-run --browsers Firefox

test-karma-unit:
	make compile-javascript
	./node_modules/karma/bin/karma start tests/config/karma.conf.unit.js

test-karma-unit-travis-ci:
	make compile-javascript
	./node_modules/karma/bin/karma start tests/config/karma.conf.unit.js --single-run --browsers Firefox

#test-karma-travis-ci: test-karma-unit-travis-ci test-karma-e2e-travis-ci
test-karma-travis-ci: test-karma-unit-travis-ci

test-travis-ci: test-backend-unit test-karma-travis-ci

nodemon:
	make compile-javascript
	foreman start -f Procfile.dev -p 5000

.PHONY: nodemon compile-javascript test-karma-unit test-karma-e2e test-mangouste
