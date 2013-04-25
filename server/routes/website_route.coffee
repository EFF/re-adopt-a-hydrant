class WebsiteRoute
    index: (req, res) ->
        if req.user
            res.redirect '/home'
        else
            res.render 'index'
    home: (req, res) ->
        res.render 'index'

module.exports = new WebsiteRoute()
