mongoose = require 'mongoose'
User = mongoose.model 'User'

class UserInteractor
    getById: (id, callback) ->
        User.findById id, 'id username displayName name', callback

module.exports = new UserInteractor()
