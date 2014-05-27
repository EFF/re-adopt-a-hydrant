async = require 'async'
request = require 'request'
adoptionInteractor = require './adoption_interactor'

class HydrantInteractor
    search: (options, callback) =>
        query = @_createQuery options.lat, options.lon
        options =
            method: 'POST'
            url: "http://#{process.env.OPENIFY_API_URL}:#{process.env.OPENIFY_API_PORT}/#{process.env.OPENIFY_API_VERSION}/#{process.env.INDEX}/#{process.env.TYPE}"
            json: query

        request(options, @_handleSearchCallback.bind(@, callback))

    _handleSearchCallback: (callback, err, res, data) =>
        hydrants = data.hits.hits
        if err
            callback err
        else
            @_attachAdoptionToHydrants hydrants, callback

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
                            distance: '2km',
                            geo:
                                lat: lat,
                                lon : lon
            sort: [
                _geo_distance:
                    geo:
                        lat: lat
                        lon: lon
                    order: 'asc'
                    unit: 'km'
            ]

        return query

module.exports = new HydrantInteractor()
