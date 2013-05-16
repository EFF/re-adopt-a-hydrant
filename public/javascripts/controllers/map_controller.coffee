goog.provide "reAdoptAHydrant.controllers.Map"

reAdoptAHydrant.controllers.Map = ($scope, HydrantService, UserService) ->
    isPaused = false
    hydrants = {}
    options =
        center: new google.maps.LatLng(46.813953, -71.207972)
        replace: true
        zoom: 15
        mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(document.getElementById("map-canvas"), options)
    google.maps.event.addListener map, "center_changed", ->
        unless isPaused
            isPaused = true
            setTimeout (->
                HydrantService.search map.getCenter().lat(), map.getCenter().lng(), (err, data) ->
                    isPaused = false
                    if err
                        console.log err
                    else
                        count = 0
                        i = 0

                        while i < data.length
                            hydrant = data[i]
                            unless hydrants[hydrant._id]
                                count++
                                hydrants[hydrant._id] = true
                                setTimeout createMarker.bind(createMarker, hydrant._id, hydrant.adopter, hydrant._source.location.lat, hydrant._source.location.lon), count * 200
                            i++

            ), 1000

    createMarker = (id, adopter, lat, lon) ->
        icon =
            anchor: new google.maps.Point(16, 39)
            size: new google.maps.Size(33, 39)
            url: (if (adopter) then "/images/adoptedHydrantMarker.png" else "/images/normalHydrantMarker.png")

        shadow =
            anchor: new google.maps.Point(6, 24)
            size: new google.maps.Size(40, 24)
            url: "/images/markerShadow.png"

        markerOptions =
            map: map
            animation: google.maps.Animation.DROP
            position: new google.maps.LatLng(lat, lon)
            icon: icon
            shadow: shadow

        marker = new google.maps.Marker(markerOptions)
        marker._id = id
        marker._adopter = adopter
        google.maps.event.addListener marker, "click", ->
            _this = this
            if @_adopter
                UserService.getUserById @_adopter, (err, user) ->
                    if err
                        console.log err
                    else
                        content = "<img class='pull-left' src='http://graph.facebook.com/" + user.id + "/picture'><p>Adopted by <strong>" + user.displayName + "</strong>"
                        infowindow = new google.maps.InfoWindow(content: content)
                        infowindow.open map, _this

            else
                UserService.getCurrentUser (err, user) ->
                    if err
                        console.log err
                    else if user
                        confirmation = confirm("Do you want to adopt this hydrant?")
                        if confirmation
                            HydrantService.adopt user._id, _this._id, (err, callback) ->
                                if err
                                    console.log err
                                else
                                    _this.setIcon "/images/adoptedHydrantMarker.png"

                    else
                        alert "You must be logged in to adopt an hydrant."


        marker

    handleUserPosition = (position) ->
        setMapCenter position.coords.latitude, position.coords.longitude

    setMapCenter = (lat, lon) ->
        newCenter = new google.maps.LatLng(lat, lon)
        map.setCenter newCenter

    handleError = (error) ->
        console.log error

    if navigator.geolocation
        navigator.geolocation.getCurrentPosition handleUserPosition, handleError
    else
        alert "Geolocation not supported"
