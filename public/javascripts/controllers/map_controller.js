goog.provide('reAdoptAHydrant.controllers.Map');

reAdoptAHydrant.controllers.Map = function($scope, HydrantService, UserService){
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
                                setTimeout(createMarker.bind(createMarker, hydrant._id, hydrant.adopter, hydrant._source.location.lat,hydrant._source.location.lon), count * 200);
                            }
                        }
                    }
                });
            }, 1000);
        }
    });

    var createMarker = function(id, adopter, lat, lon){
        var icon = {
            anchor: new google.maps.Point(16,39),
            size: new google.maps.Size(33,39),
            url: (adopter) ? '/images/adoptedHydrantMarker.png' : '/images/normalHydrantMarker.png'
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

        var marker = new google.maps.Marker(markerOptions);
        marker._id = id;
        marker._adopter = adopter;
        google.maps.event.addListener(marker, 'click', function(){
            var _this = this;
            if(this._adopter){
                var infowindow = new google.maps.InfoWindow({
                    content: 'Hello' + this._adopter
                });
                infowindow.open(map,_this);
            }
            else{
                UserService.getUser(function(err, user){
                    if(err){
                        console.log(err);
                    }
                    else if(user){
                        var confirmation = confirm('Do you want to adopt this hydrant?');
                        if(confirmation){
                            HydrantService.adopt(user._id, _this._id, function(err, callback){
                                if(err){
                                    console.log(err);
                                }
                                else{
                                    _this.setIcon('/images/adoptedHydrantMarker.png');
                                }
                            });
                        }
                    }
                    else{
                        alert('You must be logged in to adopt an hydrant.');
                    }
                });
            }
        });
        return marker;
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
