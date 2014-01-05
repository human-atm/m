
app.service 'Gimbal', ($http, $rootScope) ->
    url = "http://llama.services.42debut.com/gimbal"
    state = value:-90

    fetch = ->
        $http.get(url).then (response) -> response.data.value

    updateState = ->
        $rootScope.$apply()
        fetch().then (value) ->
            state.value = (parseInt(value) + 30) * -1

    startUpdateLoop = (interval) ->
        setInterval updateState, interval

    init: ->
        startUpdateLoop(1000)

    getValue: ->
        state.value