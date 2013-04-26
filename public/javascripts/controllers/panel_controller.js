function PanelCtrl($scope, UserService, $location){
    $scope.user = null;
    UserService.getUser(function(err, user){
        $scope.user = user;
    });
}
