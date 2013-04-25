lingua = require 'lingua'
passport = require 'passport'
strategyFactory = require './strategyFactory'
stylus = require 'stylus'
nib = require 'nib'
fs = require 'fs'
express = require 'express'
path = require 'path'

sessionMiddleware = require './middlewares/session_middleware'
localsMiddleware = require './middlewares/locals_middleware'

module.exports = (app) ->
    compileStylus = (str, path)->
        return stylus(str)
            .set('filename', path)
            .set('compress', true)
            .use(nib())
            .import('nib')
    app.configure () ->
        publicDirectory = path.join __dirname, '../public'
        app.set 'port', process.env.PORT || 3000

        app.set 'views', __dirname + '/views'
        app.set 'view engine', 'jade'

        app.disable 'x-powered-by'    
        app.use express.favicon()
        app.use express.bodyParser()
        app.use express.methodOverride()
        app.use express.cookieParser(process.env.SESSION_SECRET)
        app.use lingua(app, {storageKey: 'lang', defaultLocale: 'en', path: __dirname + '/i18n'})
        app.use stylus.middleware({src : publicDirectory, compile : compileStylus})
        app.use express.static(publicDirectory)
        app.use express.session()
        
        app.use passport.initialize()
        passport.use strategyFactory.create('facebook')
        passport.use strategyFactory.create('twiter')
        passport.serializeUser sessionMiddleware.serialize
        passport.deserializeUser sessionMiddleware.deserialize
        app.use passport.session()

        app.use localsMiddleware.setLocals
        app.use app.router

        
