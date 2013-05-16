goog.provide 'reAdoptAHydrant.services.HydrantService'

reAdoptAHydrant.services.HydrantService = ($rootScope, $http) ->
    service =
        search: (lat, lon, callback) ->
            config =
                method: 'GET'
                url: '/api/hydrants'
                params:
                    lat: lat
                    lon: lon
            $http(config).success((data, status, headers, config) ->
                    callback null, data
                ).error((data, status, headers, config) ->
                    callback data
                )
        adopt: (userId, hydrantId, callback) ->
            $http.post('/api/adopt', {userId: userId, hydrantId: hydrantId})
                .success((data, status, headers, config) ->
                    $rootScope.$broadcast 'adoption', userId, hydrantId
                    callback null, data
                )
                .error((data, status, headers, config) ->
                    callback data
                )
