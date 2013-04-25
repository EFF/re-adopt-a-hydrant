function HeaderCtrl($scope, UserService){
    $scope.user = null;
    UserService.getUser(function(err, user){
        $scope.user = user;
    });
}
