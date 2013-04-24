var app = angular.module('reAdoptAHydrant', []);

app.controller('fbCtrl', function($scope){
    $scope.init = function(fbAppId) {
        $scope.fbAppId = fbAppId;
    };

    window.fbAsyncInit = function() {
        FB.init({
            appId      : $scope.fbAppId,                        // App ID from the app dashboard
            // channelUrl : appUrl + 'channel.html', // Channel file for x-domain comms
            status     : true,                                 // Check Facebook Login status
            xfbml      : true                                  // Look for social plugins on the page
    });

        FB.getLoginStatus(function(response) {
            if (response.status === 'connected') {
                // connected
                //TODO: show the stuff
                console.log("antoine!");
                testAPI();
            } else if (response.status === 'not_authorized') {
                // not_authorized
                console.log('not_authorized');
            } else {
                // not_logged_in
                //TODO : not show the stuff
                console.log('not_authorized');
            }
        });

    // Additional initialization code such as adding Event Listeners goes here
    };

    (function(d, s, id){
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    function testAPI() {
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function(response) {
            console.log('Good to see you, ' + response.name + '.');
            console.log(response);
        });
    }
}).controller('headerCtrl', function($scope, $http){
    $scope.fbLogin = function(){
        FB.login(function(response) {
            if (response.authResponse) {
                testapi();
                // connected
            } else {
                // cancelled
                console.log('cancelled');
            }
        });
    };

    var testapi = function(){
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function(response) {
            console.log('Good to see you, ' + response.name + '.');
            console.log(response);
        });
    };
});

app.directive('map', function () {
    return {
        restrict: 'E',
        template: '<div></div>',
        link: function ($scope, element, attrs) {
            var options = {
                center: new google.maps.LatLng(46.813953,-71.207972),
                replace: true,
                zoom: 12,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            var map = new google.maps.Map(document.getElementById("map-canvas"), options);
        }
    } 
});