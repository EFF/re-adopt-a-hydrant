mongoose = require 'mongoose'
User = mongoose.model 'User'

class SessionMiddleware
    serialize: (user, done) =>
        console.log 'serialize'
        done null, user._id
    deserialize: (_id, done) =>
        console.log 'deserialize'
        User.findById _id, done

module.exports = new SessionMiddleware()
