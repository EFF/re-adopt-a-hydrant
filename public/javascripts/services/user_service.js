goog.provide('reAdoptAHydrant.services.UserService');

reAdoptAHydrant.services.UserService = function($http){
    var _getUserFromServer = function(id, callback){
        config = {
            method: 'GET',
            url: '/api/users/' + id,
            withCredentials: true
        }
        $http(config)
            .success(function(data, status, headers, config){
                callback(null, data);
            })
            .error(function(data, status, headers, config){
                callback(data)
            });
    };

    var _getUserById = function(id, callback){
        var storageKey = 'user-' + id;
        if(localStorage){
            if(localStorage[storageKey]){
                callback(null, JSON.parse(localStorage[storageKey]));
            }
            else{
                _getUserFromServer(id, function(err, data){
                    if(err){
                        callback(err);
                    }
                    else{
                        localStorage[storageKey] = JSON.stringify(data);
                        callback(null, data);
                    }
                });
            }
        }
        else{
            _getUserFromServer(id, callback);
        }
    };

    var _getAdoptionsByUserId = function(id, callback){
        config = {
            method: 'GET',
            url: '/api/users/' + id + '/adoptions',
            withCredentials: true
        }
        $http(config)
            .success(function(data, status, headers, config){
                callback(null, data);
            })
            .error(function(data, status, headers, config){
                callback(data)
            });
    };

    return {
        getCurrentUser:function(callback){
            _getUserById('me', callback);
        },
        getUserById: function(id, callback){
            _getUserById(id, callback);
        },
        getAdoptionsByUserId: function(id, callback){
            _getAdoptionsByUserId(id, callback);
        }
    }
}
