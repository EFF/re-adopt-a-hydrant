goog.provide('reAdoptAHydrant.services.HydrantService');

reAdoptAHydrant.services.HydrantService = function($rootScope, $http){
    return {
        search: function(lat, lon, callback){
            config = {
                method: 'GET',
                url: '/api/hydrants',
                params:{
                    lat: lat,
                    lon: lon
                }
            }
            $http(config)
                .success(function(data, status, headers, config){
                    callback(null, data.data);
                })
                .error(function(data, status, headers, config){
                    callback(data);
                });
        }
    }
}
