mongoose = require 'mongoose'
timestamp = require 'mongoose-troop/lib/timestamp'

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
    name:
        familyName:
            type: String
            trim: true
            index: true
        givenName:
            type: String
            trim: true
            index: true
        middleName:
            type: String
            trim: true
            index: true
    gender:
        type: String
    accessToken:
        type: String
    pictureUrl:
        type: String

UserSchema = new mongoose.Schema schema

UserSchema.plugin timestamp , {useVirtual: false}

mongoose.model 'User', UserSchema
