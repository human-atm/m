
app.controller 'MainController', ($scope, $log, $location) ->
    $scope.selectedPage = 'launch'

    $scope.setPage = (page) ->
        $log.info "Selecting page `#{page}`."
        $scope.selectedPage = page

    $scope.pages =
        request:
            requestAmounts: [20, 40, 60]
            makeRequest: (amount) ->
                console.log "Request made for amount:", amount
                amount = Math.max(0, parseInt(amount))
                throw new Error("Amount must be of type `Number`.") if _.isNaN(amount)

