class ApiRoute
    searchHydrants: (req, res) ->
        res.json {toto: 'hello'}

    adoptAnHydrant: (req, res) ->
        res.json {toto: 'hello'}

module.exports = new ApiRoute()
