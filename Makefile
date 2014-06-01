compile-javascript:
	./compile_coffee_to_javascript.sh &
	./compile_javascript_with_closure_compiler.sh

nodemon:
	make compile-javascript
	foreman start -f Procfile.dev -p 3000

.PHONY: nodemon compile-javascript
