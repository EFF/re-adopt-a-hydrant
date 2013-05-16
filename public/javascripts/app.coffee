goog.provide 'reAdoptAHydrant.Application'

goog.require 'reAdoptAHydrant.services.UserService'
goog.require 'reAdoptAHydrant.services.HydrantService'
goog.require 'reAdoptAHydrant.services.Marker'

goog.require 'reAdoptAHydrant.controllers.Panel'
goog.require 'reAdoptAHydrant.controllers.Map'
goog.require 'reAdoptAHydrant.controllers.Footer'

reAdoptAHydrant.Application = () ->

reAdoptAHydrant.Application::start = () ->
    app = angular.module 'reAdoptAHydrant', ['ngCookies']

    app.factory 'UserService', ['$http', reAdoptAHydrant.services.UserService]
    app.factory 'HydrantService', ['$rootScope', '$http', reAdoptAHydrant.services.HydrantService]
    app.factory 'MarkerService', ['UserService', 'HydrantService', reAdoptAHydrant.services.Marker]
    
    app.controller 'panelCtrl', ['$scope', 'UserService', '$location', 'HydrantService', reAdoptAHydrant.controllers.Panel]
    app.controller 'mapCtrl', ['$scope', 'HydrantService', 'UserService', 'MarkerService', reAdoptAHydrant.controllers.Map]
    app.controller 'footerCtrl', ['$scope', '$cookies', reAdoptAHydrant.controllers.Footer]

goog.exportSymbol 'reAdoptAHydrant', reAdoptAHydrant
goog.exportSymbol 'reAdoptAHydrant.Application', reAdoptAHydrant.Application
goog.exportProperty reAdoptAHydrant.Application, 'start', reAdoptAHydrant.Application::start
