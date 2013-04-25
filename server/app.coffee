path = require 'path'
express = require 'express'
fs = require 'fs'
mongoose = require 'mongoose'

app = express()

mongoose.connect process.env.MONGODB_URL
models = fs.readdirSync path.join(__dirname, '/models')
for model in models
    require(path.join(path.join(__dirname, '/models'), model))

require('./configure')(app)
require('./routes_map')(app)

app.listen app.get('port'), (err) ->
    if err
        throw err
    else
        console.log "app started on port #{app.get('port')}"
