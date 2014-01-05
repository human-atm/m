
_           = require 'lodash' # read underscore.js documentation for more info
express     = require 'express'
httpRequest = require 'request'
Promise     = require 'bluebird'
chance      = new (require 'chance')()


config =
    host:     process.env.M_HOST or '127.0.0.1'
    port:     process.env.M_PORT or 4444
    esri:url: process.env.ESRI_URL or \
    "http://services2.arcgis.com/N5FMD52YG8VXSFle/arcgis/rest/services/peeps/FeatureServer/0"


peeps = {}


class PeepsFeatureLayerAPI

    getPeeps: ->
        endpoint = 'query?where=1%3D1&objectIds=&time=&geometry=&geometryType=esriGeometryEnvelope&inSR=&spatialRel=esriSpatialRelIntersects&outFields=*&returnGeometry=true&maxAllowableOffset=&geometryPrecision=&outSR=&returnIdsOnly=false&returnCountOnly=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&f=json&token='
        @_request.get(endpoint).then (result) ->
            result = result.features
            result.map (result) ->
                id: result.attributes.OBJECTID
                location:
                    longitude: result.geometry.x
                    latitude:  result.geometry.y

    createPeep: (location) ->
        throw new Error("Location is invalid.") if not location
        peep =
            attributes:
                id:'peep'
            geometry:
                x: location.longitude
                y: location.latitude
        @_applyEdits(add:peep).then (response) ->
            id = response.addResults[0].objectId
            peeps[id] = Date.now()
            return {id, location}


    updatePeep: (id, location) ->
        peep =
            attributes:
                OBJECTID:id
            geometry:
                x: location.longitude
                y: location.latitude
        @_applyEdits(update:peep).then (response) ->
            peeps[id] = Date.now()
            return {id, location}


    deletePeeps: (peepIds = []) ->
        return if peepIds.length is 0
        peepIds = peepIds.map (id) -> parseInt(id)
        console.log "Deleting peeps:", peepIds
        @_applyEdits(del:peepIds).then ->
            peepIds.forEach (id) -> delete peeps[id]


    _applyEdits: ({add, update, del}) ->
        @_request.post 'applyEdits',
            adds:    JSON.stringify(add)
            updates: JSON.stringify(update)
            deletes: JSON.stringify(del)


    _request: do ->
        _request = (method) -> (endpoint, data) =>
            deferred = Promise.defer()
            data = _.extend {}, data, f:'json'
            console.log method.toUpperCase(), "#{config.esri.url}/#{endpoint}"
            console.log "REQUEST BODY:\n"
            console.log data
            httpRequest[method].call httpRequest, "#{config.esri.url}/#{endpoint}", {form:data}, (err, response) ->
                return deferred.reject(err) if err
                return deferred.resolve(JSON.parse(response.body))
            return deferred.promise
        post: _request('post')
        get:  _request('get')




RequestController = ->
    request = null
    createRequest: (peepId, amount) ->
        amount = parseInt(amount)
        console.log "Setting request for peep `#{peepId}`, for $#{amount}."
        request = {from:peepId, amount}
    getRequest: ->
        return request
    acceptRequest: (peepId) ->
        request = null
        console.log "Request was accepted by `#{peepId}`."


app = express()

app.use express.json()
app.use express.urlencoded()


peepsApi          = new PeepsFeatureLayerAPI()
requestController = new RequestController()

peepsApi.getPeeps().then (result) ->

    now = Date.now()
    result.forEach ({id}) ->
        peeps[id] = now

    setInterval (->
        now = Date.now()
        console.log "peeps", peeps
        expired = Object.keys(peeps).filter (id) ->
            timestamp = peeps[id]
            console.log 'ts', now, timestamp, now - timestamp
            return now - timestamp > 10000
        console.log "Peeps to delete:", expired
        peepsApi.deletePeeps(expired)
    ), 1000


app.get "/request", (req, res, next) ->
    res.send requestController.getRequest()


app.get "/peeps", (req, res, next) ->
    res.send peepsApi.getPeeps()


app.post "/peeps/:id/request", (req, res, next) ->
    {id} = req.params
    {amount} = req.body
    req.send requestController.createRequest(id, amount)


app.post "/peeps/:id/request/accept", (req, res, next) ->
    {id} = req.params
    res.send requestController.acceptRequest()


app.post "/peeps", (req, res, next) ->
    console.log req.body
    {location} = req.body
    console.log "Creating peep with location:", location
    peepsApi.createPeep(location).then (peep) ->
        res.send peep


app.post "/peeps/:id", (req, res, next) ->
    console.log req.body
    {id} = req.params
    {location} = req.body
    console.log "Updating peep `#{id}` with location:", location
    peepsApi.updatePeep(id, location).then (peep) ->
        res.send peep


console.log "server online, bro"
console.log "http://#{config.host}:#{config.port}"
app.listen config.port, config.host


process.once 'SIGINT', ->
    console.log "\nbye ;-;"
    process.exit(0)
