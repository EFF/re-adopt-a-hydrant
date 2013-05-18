async = require 'async'
OpenifyItClient = require('nodejs-api-client').OpenifyItClient
adoptionInteractor = require './adoption_interactor'

class HydrantInteractor
    constructor: () ->
        @client = new OpenifyItClient(process.env.API_HOST || 'api-staging.openify.it', process.env.API_PORT || 80, process.env.API_KEY, process.env.SECRET_KEY)

    search: (options, callback) =>
        query = @_createQuery options.lat, options.lon
        params = 
            limit: options.limit || 10
            offset: options.offset || 0
        @client.path 'POST', "/datasets/#{process.env.DATASET_ID}/search", params, {}, query, @_handleSearchCallback.bind(@, callback)

    _handleSearchCallback: (callback, err, data) =>
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
            sort: [
                _geo_distance:
                    location:
                        lat: lat
                        lon: lon

            ]
            query:
                filtered:
                    query:
                        match_all: {}
                    filter:
                        geo_distance:
                            distance: '3km'
                            location:
                                lat: lat
                                lon: lon
        return query

module.exports = new HydrantInteractor()
