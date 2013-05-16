path = require 'path'
express = require 'express'
mongoose = require 'mongoose'
ModelLoader = require './model_loader'

app = express()

mongoose.connect process.env.MONGODB_URL
ModelLoader.loadSync path.join(__dirname, '/models')

require('./configure')(app)
require('./routes_map')(app)

app.listen app.get('port'), (err) ->
    if err
        throw err
    else
        console.log "app started on port #{app.get('port')}"
