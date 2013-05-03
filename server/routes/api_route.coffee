adoptionInteractor = require '../interactors/adoption_interactor'

class ApiRoute
    user: (req, res) ->
        res.json req.user

    userAdoptions: (req, res) ->
        adoption_interactor.getUserAdoptions req.params.id, (err, data) =>
            if err
                res.json err
            else
                res.json data

    searchHydrants: (req, res) ->
        res.json {toto: 'hello'}
        
    adoptAnHydrant: (req, res) ->
        res.json {toto: 'hello'}

module.exports = new ApiRoute()
