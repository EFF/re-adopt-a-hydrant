describe 'reAdoptAHydrant.Application', () ->
    beforeEach () ->
        goog.require 'reAdoptAHydrant.Application'

    it 'should have a start function', () ->
        chai.assert.isFunction reAdoptAHydrant.Application
        application = new reAdoptAHydrant.Application()
        chai.assert.ok application
        chai.assert.isFunction application.start
