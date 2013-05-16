goog.provide 'reAdoptAHydrant.services.UserService'

reAdoptAHydrant.services.UserService = ($http) ->
    _getUserFromServer = (id, callback) ->
        config =
            method: 'GET'
            url: "/api/users/#{id}"
            withCredentials: true
        $http(config).success((data, status, headers, config) ->
                callback null, data
            )
            .error((data, status, headers, config) ->
                callback data
            )

    _getUserById = (id, callback) ->
        storageKey = "user-#{id}"
        if localStorage
            if localStorage[storageKey]
                callback null, JSON.parse(localStorage[storageKey])
            else
                _getUserFromServer id, (err, data) ->
                    if err
                        callback err
                    else
                        localStorage[storageKey] = JSON.stringify data
                        callback null, data
        else
            _getUserFromServer id, callback

    _getAdoptionsByUserId = (id, callback) ->
        config =
            method: 'GET'
            url: "/api/users/#{id}/adoptions"
            withCredentials: true
        $http(config).success((data, status, headers, config) ->
                callback null, data
            ).error((data, status, headers, config) ->
                callback data
            )

    service = 
        getCurrentUser: (callback) ->
            _getUserById 'me', callback
        getUserById: (id, callback) ->
            _getUserById id, callback
        getAdoptionsByUserId: (id, callback) ->
            _getAdoptionsByUserId id, callback

    return service
