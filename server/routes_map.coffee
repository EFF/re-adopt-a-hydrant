authenticationRoute = require './routes/authentication_route'

module.exports = (app) ->
    app.get '/', (req, res) ->
        res.render 'index'

    app.get '/auth/facebook', authenticationRoute.facebook
    app.get '/auth/facebook/callback', authenticationRoute.facebookCallback
    app.get '/auth/twitter', authenticationRoute.twitter
    app.get '/auth/twitter/callback', authenticationRoute.twitterCallback
