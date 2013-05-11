goog.provide('reAdoptAHydrant.controllers.Panel');

reAdoptAHydrant.controllers.Panel = function($scope, UserService, $location){
    $scope.user = null;
    $scope.adoptionsCount = 0;
    UserService.getCurrentUser(function(err, user){
        $scope.user = user;
    });

    $scope.$watch('user', function(){
        UserService.getAdoptionsByUserId($scope.user._id, function(err, data){
            if(data){
                $scope.adoptionsCount = data.length;
            }
        });
    });

    $scope.$on('adoption', function(eventArg, userId, hydrantId){
        $scope.adoptionsCount++;
    });
};
