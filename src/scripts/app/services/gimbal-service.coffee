
app.service 'Gimbal', ($http, $rootScope) ->
    url   = "http://llama.services.42debut.com/gimbal"
    state = {value:'∞'}

    fetch = ->
        $http.get(url).then (response) ->
            value = response.data.value
            return Math.floor Math.pow((-(parseInt(value) + 46) / 5.0), 2)

    updateState = ->
        cb = (value) ->
            state.value = value
            updateState()
        fetch().then cb, (-> cb state.value)

    init: ->
        updateState()

    getValue: ->
        state.value