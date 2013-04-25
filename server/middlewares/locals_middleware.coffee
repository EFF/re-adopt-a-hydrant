class LocalsMiddleware
    setLocals: (req, res, next) ->
        res.locals.apiKey = process.env.GMAPS_API_KEY
        next()

module.exports = new LocalsMiddleware()
