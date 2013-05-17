goog.provide 'reAdoptAHydrant.services.UserService'

reAdoptAHydrant.services.UserService = ($http) ->
    _getUserById = (id, callback) ->
        options =
            method: 'GET'
            url: "/api/users/#{id}"
            withCredentials: true

        $http(options)
            .success(_handleGetUserSuccess.bind(@, callback))
            .error(_handleGetUserError.bind(@, callback))

    _handleGetUserSuccess = (callback, user) ->
        console.log user
        callback null, user

    _handleGetUserError = (callback, err) ->
        callback err

    service = 
        getCurrentUser: (callback) ->
            _getUserById 'me', callback
        getUserById: (id, callback) ->
            _getUserById id, callback

    return service
