passport = require 'passport'

class AuthenticationRoute
    facebook: passport.authenticate('facebook')
    facebookCallback: passport.authenticate('facebook', {successRedirect: '/', failRedirect: '/'})
    twitter: passport.authenticate('twitter')
    twitterCallback: passport.authenticate('twitter', {successRedirect: '/', failRedirect: '/'})

module.exports = new AuthenticationRoute()
