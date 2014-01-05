
app.service 'MAPI', ($http, geolocation) ->
    url = "http://llama.services.42debut.com"

    createPeep: (location) ->
        $http.post("#{url}/peeps", {location}).then (response) ->
            return response.data

    updatePeep: (id, location) ->
        $http.post("#{url}/peeps/#{id}", {location}).then (response) ->
            return response.data
