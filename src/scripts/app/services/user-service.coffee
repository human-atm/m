
app.service 'User', (MAPI, geolocation, $rootScope) ->

    state = {}

    getLocation = ->
        geolocation.getLocation().then (data) ->
            latitude:  data.coords.latitude
            longitude: data.coords.longitude

    updateLocation = ->
        console.log "Updating user location."
        getLocation().then (location) ->
            state.location = location
            MAPI.updatePeep state.id, state.location

    init = ->
        console.log 'initializing user.'
        getLocation().then (location) ->
            MAPI.createPeep(location).then ({id, location}) ->
                console.log "Initialized user with id", id, "and location", location
                state.id       = id
                state.location = location

    startUpdateLoop = ->
        setInterval (->
            updateLocation()
            $rootScope.$apply()
        ), 1000

    init: ->
        init().then -> startUpdateLoop()

    getLocation: ->
        state.location

    toObject: ->
        {id:state.id, location:state.location}
