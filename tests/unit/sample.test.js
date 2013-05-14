describe('some sample', function() {
    beforeEach(function(){
        goog.require('reAdoptAHydrant.Application');
        this.application = new reAdoptAHydrant.Application();
    });

    it('should do something', function(){
        expect(this.application).to.be.ok();
        expect(this.application).to.have.property('start');
    });
});
