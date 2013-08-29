mongoose = require 'mongoose'

schema =
    provider:
        type: String
        trim: true
    id:
        type: String
        require: true
        trim: true
        index: true
    displayName:
        type: String
        require: true
        trim: true
    username:
        type: String
        require: true
        trim: true
    gender:
        type: String
    accessToken:
        type: String
    pictureUrl:
        type: String

UserSchema = new mongoose.Schema schema

mongoose.model 'User', UserSchema
