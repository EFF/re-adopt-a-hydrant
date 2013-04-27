goog.provide('reAdoptAHydrant.Application');

goog.require('reAdoptAHydrant.controllers.Panel');

reAdoptAHydrant.Application = function() {};

reAdoptAHydrant.Application.prototype.start = function() {

    var app = angular.module('reAdoptAHydrant', []);

    app.controller('PanelCtrl', ['$scope', reAdoptAHydrant.controllers.Panel]);

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
};

goog.exportSymbol('reAdoptAHydrant', reAdoptAHydrant);
goog.exportSymbol('reAdoptAHydrant.Application', reAdoptAHydrant.Application);
goog.exportProperty(reAdoptAHydrant.Application, 'start', reAdoptAHydrant.Application.prototype.start);
