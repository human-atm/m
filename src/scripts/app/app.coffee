
@app = app = angular.module 'm', [
    'ngAnimate'
    'geolocation'
]

# Allows CORS
app.config ($httpProvider) ->
    $httpProvider.defaults.useXDomain = true
    delete $httpProvider.defaults.headers.common['X-Requested-With']
