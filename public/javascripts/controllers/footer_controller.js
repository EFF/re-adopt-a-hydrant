goog.provide("reAdoptAHydrant.controllers.Footer");

reAdoptAHydrant.controllers.Footer = function($scope, $cookieStore){
    console.log($cookieStore.get('lang'));
    // $scope.$watch($cookieStore.get('lang'), function(newVal, oldVal){
    //     $scope.language = newVal;
    //     console.log(newVal);
    // });
    
};