compile-javascript:
	./compile_javascript.sh

test-karma-e2e:
	./node_modules/karma/bin/karma start karma.conf.e2e.js

test-karma-e2e-travis-ci:
	foreman start web -p 5060 < /dev/null &
	./node_modules/karma/bin/karma start karma.conf.e2e.js --single-run --browsers Firefox

test-karma-unit:
	make compile-javascript
	./node_modules/karma/bin/karma start karma.conf.unit.js

test-karma-unit-travis-ci:
	make compile-javascript
	./node_modules/karma/bin/karma start karma.conf.unit.js --single-run --browsers Firefox

#test-karma-travis-ci: test-karma-unit-travis-ci test-karma-e2e-travis-ci
test-karma-travis-ci: test-karma-unit-travis-ci

nodemon:
	make compile-javascript
	foreman start -f Procfile.dev -p 5000

.PHONY: nodemon compile-javascript test-karma-unit test-karma-e2e
