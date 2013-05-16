goog.provide 'reAdoptAHydrant.controllers.Panel'

reAdoptAHydrant.controllers.Panel = ($scope, UserService, $location) ->
    $scope.user = null
    $scope.adoptionsCount = 0
    UserService.getCurrentUser (err, user) ->
        $scope.user = user

    $scope.$watch 'user', () ->
        UserService.getAdoptionsByUserId $scope.user._id, (err, data) ->
            if data
                $scope.adoptionsCount = data.length

    $scope.$on 'adoption', (eventArg, userId, hydrantId) ->
        $scope.adoptionsCount++
