
app.service 'MAPI', ($http, geolocation) ->
    url = "http://localhost:4444"

    createPeep: (location) ->
        $http.post("#{url}/peeps", {location}).then (response) ->
            return response.data

    updatePeep: (id, location) ->
        $http.post("#{url}/peeps/#{id}", {location}).then (response) ->
            return response.data
