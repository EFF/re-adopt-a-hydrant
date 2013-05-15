describe 'reAdoptAHydrant.services.', () ->
    describe 'HydrantService', () ->
        before () ->
            goog.require 'reAdoptAHydrant.services.HydrantService'

        it 'should contain all the methods of the service', () ->
            chai.assert.isFunction reAdoptAHydrant.services.HydrantService
            hydrantService = new reAdoptAHydrant.services.HydrantService()
            chai.assert.isObject hydrantService

    describe 'UserService', () ->
        before () ->
            goog.require 'reAdoptAHydrant.services.UserService'

        it 'should contain all the methods of the service', () ->
            chai.assert.isFunction reAdoptAHydrant.services.UserService
            userService = new reAdoptAHydrant.services.UserService()
            chai.assert.isObject userService
