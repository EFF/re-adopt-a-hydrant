mongoose = require 'mongoose'
User = mongoose.model 'User'

class UserInteractor
    getById: (id, callback) ->
        User.findById id, callback

module.exports = new UserInteractor()
