require 'coffee-script'
path = require 'path'
express = require 'express'
stylus = require 'stylus'
nib = require 'nib'
fs = require 'fs'
mongoose = require 'mongoose'
lingua = require 'lingua'
passport = require 'passport'
strategyFactory = require './strategyFactory'

app = express()

mongoose.connect process.env.MONGODB_URL
models = fs.readdirSync path.join(__dirname, '/models')
for model in models
    require(path.join(path.join(__dirname, '/models'), model))

User = mongoose.model 'User'

require('./configure')(app)
require('./routes_map')(app)

app.listen app.get('port'), (err) ->
    if err
        throw err
    else
        console.log "app started on port #{app.get('port')}"
