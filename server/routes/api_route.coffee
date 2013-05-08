adoptionInteractor = require '../interactors/adoption_interactor'
hydrantInteractor = require '../interactors/hydrant_interactor'

class ApiRoute
    user: (req, res) ->
        res.json req.user

    userAdoptions: (req, res) ->
        adoptionInteractor.getUserAdoptions req.params.id, (err, data) =>
            if err
                res.json err
            else
                res.json data

    searchHydrants: (req, res) ->
        hydrantInteractor.search req.query, (err, data) =>
            if err
                res.json err
            else
                res.json data
        
    adoptAnHydrant: (req, res) ->
        res.json {toto: 'hello'}

module.exports = new ApiRoute()
