fs = require 'fs'
path = require 'path'

class ModelLoader
    @loadSync: (folder) ->
        models = fs.readdirSync folder
        for model in models
            require(path.join(folder, model))

module.exports = ModelLoader
