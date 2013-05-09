authenticationRoute = require './routes/authentication_route'
sessionMiddleware = require './middlewares/session_middleware'
websiteRoute = require './routes/website_route'
apiRoute = require './routes/api_route'
passport = require 'passport'

module.exports = (app) ->
    app.get '/', websiteRoute.index
    app.get '/api/hydrants', sessionMiddleware.ensureLoggedIn, apiRoute.searchHydrants
    app.post '/api/adopt', sessionMiddleware.ensureLoggedIn, apiRoute.adoptAnHydrant
    app.get '/api/users/me', sessionMiddleware.ensureLoggedIn, apiRoute.me
    app.get '/auth/facebook', authenticationRoute.facebook
    app.get '/auth/facebook/callback', authenticationRoute.facebookCallback
    app.get '/auth/twitter', authenticationRoute.twitter
    app.get '/auth/twitter/callback', authenticationRoute.twitterCallback

    app.get '/api/users/:id', apiRoute.user
    app.get '/api/users/:id/adoptions', sessionMiddleware.ensureLoggedIn, apiRoute.userAdoptions
