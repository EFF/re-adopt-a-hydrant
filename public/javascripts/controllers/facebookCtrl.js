function facebookCtrl ($scope) {
    $scope.init = function(fbAppId) {
        $scope.fbAppId = fbAppId;
    };

    window.fbAsyncInit = function() {
        FB.init({
            appId : $scope.fbAppId,
            redirect_uri:  "",
            status : true,
            xfbml : true
    });

    //     FB.getLoginStatus(function(response) {
    //         if (response.status === 'connected') {
    //             // connected
    //             //TODO: show the stuff
    //             console.log(response);
    //             testAPI();
    //         } else if (response.status === 'not_authorized') {
    //             // not_authorized
    //             // hide the stuff
    //             console.log('not_authorized');
    //         } else {
    //             // not_logged_in
    //             //hide the stuff
    //             console.log('not_authorized');
    //         }
    //     });
    // };

    // (function(d, s, id){
    //     var js, fjs = d.getElementsByTagName(s)[0];
    //     if (d.getElementById(id)) {return;}
    //     js = d.createElement(s); js.id = id;
    //     js.src = "//connect.facebook.net/en_US/all.js";
    //     fjs.parentNode.insertBefore(js, fjs);
    // }(document, 'script', 'facebook-jssdk'));

    // function testAPI() {
    //     console.log('Welcome!  Fetching your information.... ');
    //     FB.api('/me', function(response) {
    //         console.log('Good to see you, ' + response.name + '.');
    //         console.log(response);
    //     });
    // }
}