class HydrantInteractor
    search: (lat, lon, callback) ->
        callback null, [{todo: 'fetch data from openify.it'}]
    adopt: (userId, hydrantId, callback) ->
        callback null

module.exports = new HydrantInteractor()
