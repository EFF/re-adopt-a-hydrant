
goog.provide('reAdoptAHydrant.Application');

goog.require('reAdoptAHydrant.services.UserService');
goog.require('reAdoptAHydrant.controllers.Panel');
goog.require('reAdoptAHydrant.directives.Map');

reAdoptAHydrant.Application = function() {};

reAdoptAHydrant.Application.prototype.start = function() {

    var app = angular.module('reAdoptAHydrant', []);

    app.factory('UserService', ['$http', reAdoptAHydrant.services.UserService]);

    app.controller('panelCtrl', ['$scope', 'UserService', '$location', reAdoptAHydrant.controllers.Panel]);

    app.directive('map', reAdoptAHydrant.directives.Map);
}

goog.exportSymbol('reAdoptAHydrant', reAdoptAHydrant);
goog.exportSymbol('reAdoptAHydrant.Application', reAdoptAHydrant.Application);
goog.exportProperty(reAdoptAHydrant.Application, 'start', reAdoptAHydrant.Application.prototype.start);
