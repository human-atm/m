
_       = require 'lodash' # read underscore.js documentation for more info
express = require 'express'
request = require 'request'
Promise = require 'bluebird'


config =
    host:     process.env.M_HOST or '127.0.0.1'
    port:     process.env.M_PORT or 4444
    esri:url: process.env.ESRI_URL or \
    "http://services2.arcgis.com/N5FMD52YG8VXSFle/ArcGIS/rest/services/peeps/FeatureServer/0"


class PeepsFeatureLayerAPI

    # @ means `this`, kindof like a public variable
    constructor: (@url) ->

    getPeeps: ->
        # TODO

    addPeeps: (peeps) ->
        peeps = [peeps] if not _.isArray(peeps)
        peeps = peeps.map (peep) ->
            {location} = peep # unpacking `location` from `peep` object
            attributes:id:'peep'
            geometry:
                x: location.longitude
                y: location.latitude
        @_request.post('addFeatures', peeps).then (response) ->
            console.log response
            return response

    updatePeeps: (peeps) ->
        peeps = [peeps] if not _.isArray(peeps)
        peeps = peeps.map (peep) ->
            {id, location} = peep
            attributes:
                OBJECTID:id
            geometry:
                x: location.longitude
                y: location.latitude
        @_request.post('updateFeatures', peeps).then (response) ->
            console.log response
            return response

    # leading underscores means "private" method, like python
    # `do` means "create an anonymous function and call it immediately"
    _request: do ->
        # function that returns a function
        _request = (method) -> (endpoint, data) ->
            deferred = Promise.defer()
            request[method].call request, "#{@url}/#{endpoint}", body:data, (err, response) ->
                return deferred.reject(err) if err
                return deferred.resolve(response)
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


app.post "/peeps/:id/location", (req, res, next) ->
    {id} = req.params
    {location} = req.body
    try
        console.log "Updating location for peep `#{id}`: #{location}"
        res.send peepsApi.updatePeeps(id, location)
    catch error
        res.send 400, error.message
    finally
        next()


process.once 'SIGINT', ->
    console.log "bye ;-;"
    process.exit()


console.log "server online, bro"
console.log "http://localhost:3000"
app.listen
