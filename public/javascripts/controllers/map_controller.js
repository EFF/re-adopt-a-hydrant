// Generated by CoffeeScript 1.6.2
goog.provide("reAdoptAHydrant.controllers.Map");

reAdoptAHydrant.controllers.Map = function($scope, HydrantService, UserService, MarkerService) {
  var dropedHydrants, getAndPlaceHydrants, handleError, handleUserPosition, initialize, isPaused, map, setMapCenter;

  isPaused = false;
  dropedHydrants = {};
  map = null;
  initialize = function() {
    var options;

    options = {
      center: new google.maps.LatLng(46.813953, -71.207972),
      replace: true,
      zoom: 15,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map-canvas"), options);
    getAndPlaceHydrants();
    return google.maps.event.addListener(map, "dragend", getAndPlaceHydrants);
  };
  getAndPlaceHydrants = function() {
    return HydrantService.search(map.getCenter().lat(), map.getCenter().lng(), function(err, data) {
      var count, hydrant, i, _results;

      isPaused = false;
      if (err) {
        return console.log(err);
      } else {
        count = 0;
        i = 0;
        _results = [];
        while (i < data.length) {
          hydrant = data[i];
          if (!dropedHydrants[hydrant._id]) {
            count++;
            dropedHydrants[hydrant._id] = true;
            setTimeout(MarkerService.createMarker.bind(MarkerService.createMarker, map, hydrant), count * 200);
          }
          _results.push(i++);
        }
        return _results;
      }
    });
  };
  handleUserPosition = function(position) {
    setMapCenter(position.coords.latitude, position.coords.longitude);
    return getAndPlaceHydrants();
  };
  setMapCenter = function(lat, lon) {
    var newCenter;

    newCenter = new google.maps.LatLng(lat, lon);
    return map.setCenter(newCenter);
  };
  handleError = function(error) {
    return getAndPlaceHydrants();
  };
  initialize();
  if (navigator.geolocation) {
    return navigator.geolocation.getCurrentPosition(handleUserPosition, handleError);
  } else {
    return alert("Geolocation not supported");
  }
};
