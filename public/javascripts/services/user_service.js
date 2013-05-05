goog.provide('reAdoptAHydrant.services.UserService');

reAdoptAHydrant.services.UserService = function($http){
    return {
        getUser:function(callback){
            config = {
                method: 'GET',
                url: '/api/user',
                withCredentials: true
            }
            $http(config)
                .success(function(data, status, headers, config){
                    callback(null, data);
                    console.log(data);
                })
                .error(function(data, status, headers, config){
                    callback(null, false)
                });

        }
    }
}
