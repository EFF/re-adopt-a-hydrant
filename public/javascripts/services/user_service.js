goog.provide('reAdoptAHydrant.services.UserService');

reAdoptAHydrant.services.UserService = function($http){
    return {
        getCurrentUser:function(callback){
            config = {
                method: 'GET',
                url: '/api/users/me',
                withCredentials: true
            }
            $http(config)
                .success(function(data, status, headers, config){
                    callback(null, data);
                })
                .error(function(data, status, headers, config){
                    callback(null, false)
                });

        },
        getUserById: function(id, callback){
            config = {
                method: 'GET',
                url: '/api/users/' + id
            }
            $http(config)
                .success(function(data, status, headers, config){
                    callback(null, data);
                })
                .error(function(data, status, headers, config){
                    callback(null, false)
                });
        }
    }
}
