goog.provide 'reAdoptAHydrant.controllers.Panel'

reAdoptAHydrant.controllers.Panel = ($scope, UserService, $location) ->
    $scope.user = null
    $scope.adoptionsCount = 0
    $scope.adoptedHydrantsText = ''

    $.i18n.init
        fallbackLng: 'fr'
        resGetPath: 'locales/resources.json?lng=__lng__&ns=__ns__'
        dynamicLoad: true
        cookieName: 'lang'


    UserService.getCurrentUser (err, user) ->
        $scope.user = user

    $scope.$watch 'user', () ->
        UserService.getAdoptionsByUserId $scope.user._id, (err, data) ->
            if data
                $scope.adoptionsCount = data.length
                $scope.adoptedHydrantsText = $.t('adoptedHydrants',
                    count: $scope.adoptionsCount
                    context: if $scope.adoptionsCount == 0 then 'zero' else 'many'
                )

    $scope.$on 'adoption', (eventArg, userId, hydrantId) ->
        $scope.adoptionsCount++
