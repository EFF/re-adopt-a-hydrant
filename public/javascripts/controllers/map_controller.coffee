goog.provide "reAdoptAHydrant.controllers.Map"

reAdoptAHydrant.controllers.Map = ($scope, HydrantService, UserService, MarkerService) ->
    isPaused = false
    dropedHydrants = {}
    map = null

    initialize = () ->
        options =
            center: new google.maps.LatLng(46.813953, -71.207972)
            replace: true
            zoom: 16
            mapTypeId: google.maps.MapTypeId.ROADMAP

        map = new google.maps.Map(document.getElementById("map-canvas"), options)
        getAndPlaceHydrants()
        
        google.maps.event.addListener map, "dragend", getAndPlaceHydrants

    getAndPlaceHydrants = () ->
        HydrantService.search map.getCenter().lat(), map.getCenter().lng(), (err, data) ->
            isPaused = false
            if err
                console.log err
            else
                count = 0
                i = 0

                while i < data.length
                    hydrant = data[i]
                    unless dropedHydrants[hydrant._id]
                        count++
                        dropedHydrants[hydrant._id] = true
                        setTimeout MarkerService.createMarker.bind(MarkerService.createMarker, map, hydrant), count * 200
                    i++


    handleUserPosition = (position) ->
        setMapCenter position.coords.latitude, position.coords.longitude
        getAndPlaceHydrants()

    setMapCenter = (lat, lon) ->
        newCenter = new google.maps.LatLng(lat, lon)
        map.setCenter newCenter

    handleError = (error) ->
        getAndPlaceHydrants()


    initialize()
    if navigator.geolocation
        navigator.geolocation.getCurrentPosition handleUserPosition, handleError
    else
        alert "Geolocation not supported"
