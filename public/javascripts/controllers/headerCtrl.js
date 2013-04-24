function headerCtrl($scope, $http){
    $scope.fbLogin = function(){
        FB.login(function(response) {
            if (response.authResponse) {
                testFbApi();
                // connected
            } else {
                // cancelled
                console.log('cancelled');
            }
        });
    };

    var testFbApi = function(){
        console.log('Welcome!  Fetching your information.... ');
        FB.api('/me', function(response) {
            console.log('Good to see you, ' + response.name + '.');
            console.log(response);
        });
    };
};