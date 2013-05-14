describe 'reAdoptAHydrant.Application', () ->
    beforeEach () ->
        goog.require 'reAdoptAHydrant.Application'
        @application = new reAdoptAHydrant.Application()

    it 'should have a start function', () ->
        chai.assert.ok this.application
        chai.assert.isFunction this.application.start
