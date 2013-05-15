goog.provide('reAdoptAHydrant.controllers.Panel');

reAdoptAHydrant.controllers.Panel = function($scope, UserService, $location){
    $scope.user = null;
    $scope.adoptionsCount = 0;
    UserService.getCurrentUser(function(err, user){
        $scope.user = user;
    });

    $.i18n.init({
        fallbackLng: 'en',
        resGetPath: 'locales/resources.json?lng=__lng__&ns=__ns__',
        dynamicLoad: true,
        cookieName: 'lang'
    });
    
    $scope.$watch('user', function(){
        UserService.getAdoptionsByUserId($scope.user._id, function(err, data){
            if(data){
                $scope.adoptionsCount = data.length;
                $scope.adoptedHydrantsText = $.t('adoptedHydrants', {count : $scope.adoptionsCount, context: ($scope.adoptionsCount !== 0) ? 'many' : 'zero'});
            }
        });
    });

    $scope.$on('adoption', function(eventArg, userId, hydrantId){
        $scope.adoptionsCount++;
    });
};
