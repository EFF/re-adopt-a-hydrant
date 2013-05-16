passport = require 'passport'
strategyFactory = require './strategyFactory'
stylus = require 'stylus'
nib = require 'nib'
express = require 'express'
path = require 'path'
mongoose = require 'mongoose'
SessionStore = require('session-mongoose')(express)
i18n = require 'i18next'

sessionMiddleware = require './middlewares/session_middleware'

module.exports = (app) ->
    compileStylus = (str, path)->
        return stylus(str)
            .set('filename', path)
            .set('compress', true)
            .use(nib())
            .import('nib')

    app.configure () ->
        i18nOptions =
            fallbackLng: 'fr'
            resGetPath: './server/locales/__lng__/__ns__.json'
            detectLngQS: 'lang'
            cookieName: 'lang'
        i18n.init i18nOptions

        publicDirectory = path.join __dirname, '../public'

        app.locals.isDev = (app.settings.env == "development")
        app.locals.apiKey = process.env.GMAPS_API_KEY

        app.set 'port', process.env.PORT || 3000

        app.set 'views', __dirname + '/views'
        app.set 'view engine', 'jade'

        app.disable 'x-powered-by' 
        app.use express.favicon()
        app.use express.bodyParser()
        app.use express.methodOverride()
        app.use express.cookieParser(process.env.SESSION_SECRET)

        app.use stylus.middleware({src : publicDirectory, compile : compileStylus})
        app.use express.static(publicDirectory)
        store = new SessionStore(connection : mongoose.connection)
        maxAge = 7 * 24 * 60 * 60 * 1000 #one week
        app.use express.session({ store: store,cookie: { maxAge: maxAge }})
        
        app.use passport.initialize()
        passport.use strategyFactory.create('facebook')
        passport.use strategyFactory.create('twiter')
        passport.serializeUser sessionMiddleware.serialize
        passport.deserializeUser sessionMiddleware.deserialize
        app.use passport.session()

        app.use i18n.handle
        app.use app.router

        i18n.registerAppHelper(app)
            .serveClientScript(app)
            .serveDynamicResources(app)
            .serveMissingKeyRoute(app)

    app.configure 'development', () ->
        app.use express.logger('dev')
        app.use express.errorHandler({ dumpExceptions: true, showStack: true })
        closureDirectory = path.join __dirname, '../vendors/closure-library/closure/goog'
        app.use('/closure', express.static(closureDirectory))
