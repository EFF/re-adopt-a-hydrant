goog.provide('reAdoptAHydrant.controllers.Map');

reAdoptAHydrant.controllers.Map = function($scope, HydrantService){
    var isPaused = false;
    var hydrants = {};

    var options = {
        center: new google.maps.LatLng(46.813953,-71.207972),
        replace: true,
        zoom: 15,
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
                        var count = 0;
                        for (var i = 0; i < data.length; i++){
                            var hydrant = data[i];
                            if(!hydrants[hydrant._id]){
                                count++;
                                hydrants[hydrant._id] = true;
                                setTimeout(createMarker.bind(createMarker, hydrant._source.location.lat,hydrant._source.location.lon), count * 200);
                            }
                        }
                    }
                });
            }, 1000);
        }
    });

    var createMarker = function(lat, lon){
        var icon = {
            anchor: new google.maps.Point(16,39),
            size: new google.maps.Size(33,39),
            url: '/images/normalHydrantMarker.png'
        };
        var shadow = {
            anchor: new google.maps.Point(6,24),
            size: new google.maps.Size(40,24),
            url: '/images/markerShadow.png'
        };

        var markerOptions = {
            map: map,
            animation: google.maps.Animation.DROP,
            position: new google.maps.LatLng(lat, lon),
            icon: icon,
            shadow: shadow
        };

        return new google.maps.Marker(markerOptions);
    };

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
