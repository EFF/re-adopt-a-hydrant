async = require 'async'
OpenifyItClient = require('nodejs-api-client')
adoptionInteractor = require './adoption_interactor'

class HydrantInteractor
    constructor: () ->
        @client = new OpenifyItClient(process.env.API_HOST || 'api.openify.it', process.env.API_PORT || 80, process.env.API_KEY, process.env.SECRET_KEY)

    search: (options, callback) =>
        query = @_createQuery options.lat, options.lon
        params =
            qs:
                limit: options.limit || 100
                offset: options.offset || 0
            json:
                query
        @client.path 'GET', "/v0/datasets/#{process.env.DATASET_ID}/data", params, @_handleSearchCallback.bind(@, callback)

    _handleSearchCallback: (callback, err, res, data) =>
        if err
            callback err
        else
            @_attachAdoptionToHydrants data.data, callback

    _attachAdoptionToHydrants: (hydrants, callback) =>
        result = []
        iterator = (hydrant, next) =>
            adoptionInteractor.getAdoptionByHydrantId hydrant._id, (err, adoption) =>
                if adoption and adoption.userId
                    hydrant.adopter = adoption.userId
                else
                    hydrant.adopter = null
                result.push hydrant
                next()
        async.each hydrants, iterator, (err) =>
            callback err, result

    _createQuery: (lat, lon) =>
        query =
            query:
                filtered:
                    query:
                        match_all: {}
                    filter:
                        geo_distance:
                            distance: '3km'
                            geo:
                                lat: lat
                                lon: lon
                sort: [
                    _geo_distance:
                        geo:
                            lat: lat
                            lon: lon

                ]
        return query

module.exports = new HydrantInteractor()
