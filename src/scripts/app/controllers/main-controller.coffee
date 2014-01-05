
app.controller 'MainController', ($scope, $log, $location) ->
    $scope.selectedPage = 'launch'

    $scope.setSelectedPage = (page) ->
        $log.info "Selecting page `#{page}`."
        $scope.selectedPage = page
