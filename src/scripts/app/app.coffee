
@app = app = angular.module 'm', [
    'ui'
]

# Allows CORS
app.config ($httpProvider) ->
    $httpProvider.defaults.useXDomain = true
    delete $httpProvider.defaults.headers.common['X-Requested-With']
