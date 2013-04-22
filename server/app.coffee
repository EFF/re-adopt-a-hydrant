require 'coffee-script'
path = require 'path'
express = require 'express'
stylus = require 'stylus'
nib = require 'nib'
fs = require 'fs'
mongoose = require 'mongoose'
lingua = require 'lingua'
app = express()

compileStylus= (str, path)=>
    return stylus(str)
        .set('filename', path)
        .set('compress', true)
        .use(nib())
        .import('nib')

mongoose.connect process.env.MONGODB_URL
models = fs.readdirSync path.join(__dirname, '/models')
for model in models
    require(path.join(path.join(__dirname, '/models'), model))

app.configure () =>
    publicDirectory = path.join __dirname, '../public'

    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'

    app.disable 'x-powered-by'    
    app.use express.favicon()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use lingua(app, {storageKey: 'lang', defaultLocale: 'en', path: __dirname + '/i18n'})
    app.use app.router
    app.use stylus.middleware({src : publicDirectory, compile : compileStylus})
    app.use express.static(publicDirectory)

app.get '/', (req, res)=>
    res.render('index')

# app.get('/api/search', function(req, res){
#     searchInteractor.search(req.query, function(err, results){
#         if(err){
#             res.json(err);
#         }
#         else{
#             res.json({books: results});
#         }
#     });
# });

app.listen process.env.PORT || 3000
