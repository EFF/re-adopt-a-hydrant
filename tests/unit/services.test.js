describe('reAdoptAHydrant.services.', function() {
    describe('HydrantService', function(){
        before(function(){
            goog.require('reAdoptAHydrant.services.HydrantService');
            this.hydrantService = new reAdoptAHydrant.services.HydrantService();
        });

        it('should contain all the methods of the service', function(){
            chai.assert.isFunction(reAdoptAHydrant.services.HydrantService);
            var hydrantService = new reAdoptAHydrant.services.HydrantService();
            chai.assert.isObject(hydrantService);
        });        
    });

    describe('UserService', function(){
        before(function(){
            goog.require('reAdoptAHydrant.services.UserService');
        });

        it('should contain all the methods of the service', function(){
            chai.assert.isFunction(reAdoptAHydrant.services.UserService);
            var userService = new reAdoptAHydrant.services.UserService();
            chai.assert.isObject(userService);
        });
    });
});
