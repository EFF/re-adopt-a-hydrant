#!/bin/bash
make compile-javascript
./node_modules/coffee-script/bin/coffee server/app.coffee
