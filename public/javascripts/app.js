var app = angular.module('reAdoptAHydrant', []);

app.factory('UserService', ['$http', UserService])
app.controller('HeaderCtrl', ['$scope', 'UserService', HeaderCtrl]);

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