mongoose = require 'mongoose'
userInteractor = require '../interactors/user_interactor'

class SessionMiddleware
    ensureLoggedIn: (req, res, next) ->
        if req.isAuthenticated()
            next()
        else
            res.json 401, {error: 'You must be logged in.'}
    serialize: (user, done) =>
        done null, user._id
    deserialize: (_id, done) =>
        userInteractor.getById _id, done

module.exports = new SessionMiddleware()
