class LocalsMiddleware
    setLocals: (req, res, next) ->
        res.locals.apiKey = process.env.GMAPS_API_KEY
        res.locals.accessToken = if req.user then req.user.accessToken else null
        next()

module.exports = new LocalsMiddleware()
