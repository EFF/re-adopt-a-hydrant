require 'coffee-script'
path = require 'path'
express = require 'express'
stylus = require 'stylus'
nib = require 'nib'
fs = require 'fs'
mongoose = require 'mongoose'
lingua = require 'lingua'
passport = require 'passport'
SessionStore = require('session-mongoose')(express)
strategyFactory = require './strategyFactory'

app = express()

mongoose.connect process.env.MONGODB_URL
models = fs.readdirSync path.join(__dirname, '/models')
for model in models
    require(path.join(path.join(__dirname, '/models'), model))

User = mongoose.model 'User'

compileStylus = (str, path)=>
    return stylus(str)
        .set('filename', path)
        .set('compress', true)
        .use(nib())
        .import('nib')

serialize = (user, done) =>
    done null, user.id

deserialize = (id, done) =>
    User.findOne {id : id}, (err, user) =>
        if err then done err, null
        done null, user

configurePassport = () =>
    passport.use strategyFactory.create('facebook')
    passport.use strategyFactory.create('twiter')
    passport.serializeUser serialize
    passport.deserializeUser deserialize

app.configure () =>
    publicDirectory = path.join __dirname, '../public'

    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'

    app.disable 'x-powered-by'    
    app.use express.favicon()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use lingua(app, {storageKey: 'lang', defaultLocale: 'en', path: __dirname + '/i18n'})
    app.use stylus.middleware({src : publicDirectory, compile : compileStylus})
    app.use express.static(publicDirectory)
    app.use express.cookieParser(process.env.SESSION_SECRET)
    store = new SessionStore(connection : mongoose.connection)
    maxAge = 7 * 24 * 60 * 60 * 1000 #one week
    app.use express.session({ store: store,cookie: { maxAge: maxAge }})
    
    app.use passport.initialize()
    app.use passport.session()
    app.use app.router

    configurePassport()

locals =
    apiKey : process.env.GMAPS_API_KEY
    fbAppId : process.env.FB_APP_ID

app.get '/', (req, res)=>
    res.render('index', locals)

app.get '/auth/facebook', passport.authenticate('facebook')
app.get '/auth/facebook/callback', (req, res, next) ->
    cb = (err, user, info) ->
        if err
            next err
        else if user
            res.redirect "/#access_token=#{req.query.code}"
        else
            res.redirect '/'

    passport.authenticate('facebook', cb)(req, res, next)

app.get '/auth/twitter', passport.authenticate('twitter')
app.get '/auth/twitter/callback', (req, res, next) ->
    cb = (err, user, info) ->
        if err
            next err
        else if user
            res.redirect "/#access_token=#{req.query.code}"
        else
            res.redirect '/'

    passport.authenticate('twitter', cb)(req, res, next)

app.listen process.env.PORT || 3000
