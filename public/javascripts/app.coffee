goog.provide 'reAdoptAHydrant.Application'

goog.require 'reAdoptAHydrant.services.UserService'
goog.require 'reAdoptAHydrant.services.HydrantService'
goog.require 'reAdoptAHydrant.services.Marker'

goog.require 'reAdoptAHydrant.controllers.Panel'
goog.require 'reAdoptAHydrant.controllers.Map'

reAdoptAHydrant.Application = () ->

reAdoptAHydrant.Application::start = () ->
    app = angular.module 'reAdoptAHydrant', ['ngCookies']

    app.factory 'UserService', ['$http', reAdoptAHydrant.services.UserService]
    app.factory 'HydrantService', ['$rootScope', '$http', reAdoptAHydrant.services.HydrantService]
    app.factory 'MarkerService', ['UserService', 'HydrantService', reAdoptAHydrant.services.Marker]
    
    app.controller 'panelCtrl', ['$scope', 'UserService', '$location', '$cookies', reAdoptAHydrant.controllers.Panel]
    app.controller 'mapCtrl', ['$scope', 'HydrantService', 'UserService', 'MarkerService', reAdoptAHydrant.controllers.Map]
    
    window.$.i18n.init
        fallbackLng: 'fr'
        resGetPath: 'locales/resources.json?lng=__lng__&ns=__ns__'
        dynamicLoad: true
        cookieName: 'lang'

goog.exportSymbol 'reAdoptAHydrant', reAdoptAHydrant
goog.exportSymbol 'reAdoptAHydrant.Application', reAdoptAHydrant.Application
goog.exportProperty reAdoptAHydrant.Application, 'start', reAdoptAHydrant.Application::start
