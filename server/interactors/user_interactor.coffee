mongoose = require 'mongoose'
adoptionInteractor = require './adoption_interactor'

class UserInteractor
    getById: (id, callback) ->
        User = mongoose.model 'User'
        User.findById id, 'id username displayName name pictureUrl', @_handleGetById.bind(@, callback)

    _handleGetById: (callback, err, user) =>
        if err
            callback err, user
        else
            @_findUserAdoptions user, callback

    _findUserAdoptions: (user, callback) =>
        adoptionInteractor.getUserAdoptions user._id, @_addAdoptionsToUser.bind(@, user, callback)

    _addAdoptionsToUser: (user, callback, err, adoptions) =>
        if err
            callback err
        else
            user = user.toObject()
            user.adoptions = adoptions
            callback null, user


module.exports = new UserInteractor()
