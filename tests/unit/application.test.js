describe('reAdoptAHydrant.Application', function() {
    beforeEach(function(){
        goog.require('reAdoptAHydrant.Application');
        this.application = new reAdoptAHydrant.Application();
    });

    it('should have a start function', function(){
        chai.assert.ok(this.application);
        chai.assert.isFunction(this.application.start);
    });
});
