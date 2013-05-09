goog.provide('reAdoptAHydrant.controllers.Panel');

reAdoptAHydrant.controllers.Panel = function($scope, UserService, $location){
    $scope.user = null;
    UserService.getCurrentUser(function(err, user){
        $scope.user = user;
    });
};
