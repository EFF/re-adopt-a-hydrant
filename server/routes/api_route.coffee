userInteractor = require '../interactors/user_interactor'
adoptionInteractor = require '../interactors/adoption_interactor'
hydrantInteractor = require '../interactors/hydrant_interactor'

class ApiRoute
    me: (req, res) =>
        res.json req.user

    user: (req, res) =>
        userInteractor.getById req.params.id, @apiCallback.bind(@, res)

    userAdoptions: (req, res) =>
        adoptionInteractor.getUserAdoptions req.params.id, @apiCallback.bind(@, res)

    searchHydrants: (req, res) =>
        hydrantInteractor.search req.query, @apiCallback.bind(@, res)

    adoptAnHydrant: (req, res) =>
        adoptionInteractor.adoptHydrant req.body.userId, req.body.hydrantId, @apiCallback.bind(@, res)

    apiCallback: (res, err, data) =>
        if err
            res.json 500, err
        else
            res.json data

module.exports = new ApiRoute()
