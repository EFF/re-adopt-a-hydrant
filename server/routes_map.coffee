authenticationRoute = require './routes/authentication_route'
sessionMiddleware = require './middlewares/session_middleware'
websiteRoute = require './routes/website_route'
apiRoute = require './routes/api_route'
passport = require 'passport'

module.exports = (app) ->
    app.get '/', websiteRoute.index
    app.get '/home', sessionMiddleware.ensureLoggedIn(true), websiteRoute.home
    app.get '/api/hydrants', sessionMiddleware.ensureLoggedIn(false), apiRoute.searchHydrants
    app.post '/api/adopt', sessionMiddleware.ensureLoggedIn(false), apiRoute.adoptAnHydrant
    app.get '/auth/facebook', authenticationRoute.facebook
    app.get '/auth/facebook/callback', authenticationRoute.facebookCallback
    app.get '/auth/twitter', authenticationRoute.twitter
    app.get '/auth/twitter/callback', authenticationRoute.twitterCallback
