function PanelCtrl($scope, UserService, $location){
    $scope.user = null;
    UserService.getUser(function(err, user){
        $scope.user = user;
    });

    $scope.loginFacebook = function(){
        $location.url($location.absUrl('/auth/facebook'));
    }

    $scope.loginTwitter = function(){
        $location.url($location.absUrl('/auth/twitter'));
    }
}
