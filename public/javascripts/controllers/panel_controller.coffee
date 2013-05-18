goog.provide 'reAdoptAHydrant.controllers.Panel'

reAdoptAHydrant.controllers.Panel = ($scope, UserService, $location) ->
    $scope.user = null
    $scope.adoptedHydrantsText = ''

    UserService.getCurrentUser (err, user) ->
        $scope.user = user

    $scope.$watch 'user', () ->
        if $scope.user
            _updateAdoptedHydrantText $scope.user.adoptions.length

    _updateAdoptedHydrantText = (adoptionsCount) ->
        i18nOptions =
            count: adoptionsCount,
            context : if adoptionsCount ==0 then 'zero' else 'many'

        $scope.adoptedHydrantsText = window.$.t 'adoptedHydrants', i18nOptions

    $scope.$on 'adoption', (eventArg, hydrant) ->
        $scope.user.adoptions.push hydrant
        _updateAdoptedHydrantText $scope.user.adoptions.length
