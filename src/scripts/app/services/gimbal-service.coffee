
app.service 'Gimbal', ($http, $rootScope) ->
    url = "http://llama.services.42debut.com/gimbal"
    state = value:'∞'

    fetch = ->
        $http.get(url).then (response) ->
            value = response.data.value
            return Math.floor Math.pow((-(parseInt(value) + 44) / 5.6), 2)

    updateState = ->
        $rootScope.$apply()
        fetch().then (value) ->
            state.value = value

    startUpdateLoop = (interval) ->
        setInterval updateState, interval

    init: ->
        startUpdateLoop(100)

    getValue: ->
        state.value