class WebsiteRoute
    index: (req, res) ->
        res.render 'index'
    home: (req, res) ->
        res.render 'index'

module.exports = new WebsiteRoute()
