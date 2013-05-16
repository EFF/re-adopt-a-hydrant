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
        @client.path 'POST', "/datasets/#{process.env.DATASET_ID}/search", params, {}, query, @_searchCallback.bind(@, callback)

    _searchCallback: (callback, err, data) =>
        if err
            callback err
        else
            hydrants = []
            iterator = (item, next) =>
                adoptionInteractor.getByHydrantId item._id, (err, result) =>
                    if err
                        next err
                    else
                        item.adopter = null
                        if result
                            item.adopter = result.userId
                        hydrants.push item
                        next()
            async.each data.data, iterator, (err) =>
                if err
                    callback err
                else
                    callback null, hydrants


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
                            distance: '10km'
                            location:
                                lat: lat
                                lon: lon
        return query

module.exports = new HydrantInteractor()
