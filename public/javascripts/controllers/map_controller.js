goog.provide('reAdoptAHydrant.controllers.Map');

reAdoptAHydrant.controllers.Map = function($scope, HydrantService){
    var isPaused = false;

    var options = {
        center: new google.maps.LatLng(46.813953,-71.207972),
        replace: true,
        zoom: 12,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById('map-canvas'), options);
    google.maps.event.addListener(map, 'center_changed', function() {
        if(!isPaused){
            isPaused = true;
            setTimeout(function(){
                HydrantService.search(map.getCenter().lat(), map.getCenter().lng(), function(err, data){
                    isPaused = false;
                    if(err){
                        console.log(err);
                    }
                    else{
                        console.log(data);
                    }
                });
            }, 1000);
        }
    });

    var handleUserPosition = function(position){
        setMapCenter(position.coords.latitude,position.coords.longitude);
    };

    var setMapCenter = function(lat, lon) {
        var newCenter = new google.maps.LatLng(lat, lon);
        map.setCenter(newCenter);
    };

    var handleError = function(error){
        console.log(error);
    };

    if(navigator.geolocation){
        navigator.geolocation.getCurrentPosition(handleUserPosition,handleError);
    }
    else{
        alert('Geolocation not supported');
    }
};
