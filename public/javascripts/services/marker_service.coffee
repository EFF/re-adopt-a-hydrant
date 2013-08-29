goog.provide 'reAdoptAHydrant.services.Marker'

reAdoptAHydrant.services.Marker = (UserService, HydrantService) =>

    createMarker = (map, hydrant) =>
        if hydrant.adopter
            _createAdoptedMarker map, hydrant
        else
            _createNormalHydrantMarker map, hydrant

    _createNormalHydrantMarker = (map, hydrant) =>
        icon =
            anchor : new google.maps.Point(16,39)
            size: new google.maps.Size(33,39)
            url: '/images/normalHydrantMarker.png'

        shadow =
            anchor : new google.maps.Point(6,24)
            size: new google.maps.Size(40,24)
            url: '/images/markerShadow.png'

        return _createMarker map, hydrant, icon, shadow

    _createAdoptedMarker = (map, hydrant) =>
        icon =
            anchor : new google.maps.Point(21,39),
            size: new google.maps.Size(42,39),
            url: '/images/adoptedHydrantMarker.png'

        shadow =
            anchor : new google.maps.Point(6,24)
            size: new google.maps.Size(40,24)
            url: '/images/markerShadow.png'

        return _createMarker map, hydrant, icon, shadow

    _createMarker = (map, hydrant, icon, shadow) =>
        markerOptions =
            map: map
            animation: google.maps.Animation.DROP
            position: new google.maps.LatLng(hydrant._source.geo.lat, hydrant._source.geo.lon)
            icon: icon
            shadow : shadow

        marker = new google.maps.Marker markerOptions
        _attachCLickEvent marker, hydrant

    _attachCLickEvent = (marker, hydrant) =>
        marker._id = hydrant._id
        marker._adopter = hydrant.adopter
        google.maps.event.addListener marker, "click", _handleClickEvent

    _handleClickEvent = () ->
        if @_adopter
            UserService.getUserById @_adopter, (err, user) =>
                if err
                    console.log err
                else
                    content = "<img class='pull-left' src='#{user.pictureUrl}'><p>Adopted by <strong>#{user.displayName}</strong>"
                    infowindow = new google.maps.InfoWindow(content: content)
                    infowindow.open @.map, @

        else
            UserService.getCurrentUser (err, user) =>
                if user
                    confirmation = confirm "Do you want to adopt this hydrant?"
                    if confirmation
                        console.log 'confirm', @
                        HydrantService.adopt user._id, @._id, (err, callback) =>
                            if err
                                console.log err
                            else
                                @setIcon "/images/adoptedHydrantMarker.png"
                                @_adopter = user._id

                else
                    alert "You must be logged in to adopt an hydrant."

    service =
        createMarker: createMarker

    return service
