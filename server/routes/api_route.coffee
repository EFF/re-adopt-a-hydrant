class ApiRoute
    user: (req, res) ->
        res.json req.user
    searchHydrants: (req, res) ->
        res.json {toto: 'hello'}
    adoptAnHydrant: (req, res) ->
        res.json {toto: 'hello'}

module.exports = new ApiRoute()
