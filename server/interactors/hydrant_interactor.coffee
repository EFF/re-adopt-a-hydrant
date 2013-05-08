OpenifyItClient = require('nodejs-api-client').OpenifyItClient

class HydrantInteractor
    constructor: () ->
        @client = new OpenifyItClient(process.env.API_HOST || 'api-staging.openify.it', process.env.API_PORT || 80, process.env.API_KEY, process.env.SECRET_KEY)
    search: (options, callback) =>
        query = @_createQuery options.lat, options.lon
        console.log query
        params = 
            q: query
            limit: options.limit || 10
            offset: options.offset || 0
        @client.path 'GET', "/datasets/#{process.env.DATASET_ID}/search", params, {}, {}, callback

    _createQuery: (lat, lon) =>
        console.log 'asdasdasd', lat, lon
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
        return JSON.stringify query
    adopt: (userId, hydrantId, callback) ->
        callback null

module.exports = new HydrantInteractor()
