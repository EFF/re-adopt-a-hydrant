![reAdoptAHydrant logo](https://raw.github.com/OpenifyIt/reAdoptAHydrant/master/public/images/logo.png "reAdoptAHydrant")

Try live demo http://readoptahydrant.openify.it

This project is a remake of the [Adopt-a-Hydrant](http://example.com/) built in Boston by the city of Boston. For a better description [take a look here](http://commons.codeforamerica.org/apps/adopt-hydrant "Adopt-a-Hydrant description")

This project use the open-data published by the city of Québec in Canada and serve as a demo for the platform [Openify.it](http://www.openify.it).

## Features
+ Retrieves the nearest hydrants from the Openify.it api by geo distance and add them to the map.
+ Center the map using the geolocation of the browser. If it's not supported the map is centered in the old town.
+ A user can login with Facebook or Twitter to adopt one or more hydrants and claims resposibility for it.

## Screencast
You can see a demo screencast [here](http://frxpoulin.wistia.com/medias/urbgoa1x7w)

## Technologies/Frameworks/Modules/Libraries
+ node.js
+ CoffeScript
+ AngularJS
+ Google Closure Library
+ Google Closure Compiler
+ Stylus
+ Jade
+ i18next
+ Google Maps api v3
+ MongoDB
+ Mongoose
+ Facebook OAuth login using passport.js
+ Twitter OAuth login using passport.js
+ Openify.it api
    + ElasticSearch, we use the ElasticSearch's capabillities nested inside the openify.it api.
+ Karma-runner
+ Mocha
+ Sinon.JS
+ Chai

## Desing credits
+ [Fire Hydrant](http://thenounproject.com/noun/fire-hydrant/#icon-No508) from The Noun Project
+ [Map marker](http://thenounproject.com/noun/map-marker/#icon-No5552) from The Noun Project
+ [Social login buttons](http://zocial.smcllns.com/ https://github.com/samcollins/css-social-buttons) from Zocial
