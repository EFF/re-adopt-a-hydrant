goog.provide 'reAdoptAHydrant.services.HydrantService'

reAdoptAHydrant.services.HydrantService = ($rootScope, $http) ->
    search = (lat, lon, callback) ->
        options =
            method: 'GET'
            url: '/api/hydrants'
            params:
                lat: lat
                lon: lon

        $http(options)
            .success(_handleSeachSuccess.bind(@, callback))
            .error(_handleSeachError.bind(@, callback))

    adopt = (userId, hydrantId, callback) ->
        options =
            method: 'POST'
            url: '/api/adopt'
            data:
                userId: userId
                hydrantId: hydrantId

        $http(options)
            .success(_handleAdoptSuccess.bind(@, callback))
            .error(_handleAdoptError.bind(@, callback))

    _handleSeachSuccess = (callback, data) ->
        callback null, data

    _handleSeachError = (data) ->
        callback data

    _handleAdoptSuccess = (callback, data) ->
        $rootScope.$broadcast 'adoption', data
        callback null, data

    _handleAdoptError = (data) ->
        callback data

    service = 
        search: search
        adopt: adopt

    return service

