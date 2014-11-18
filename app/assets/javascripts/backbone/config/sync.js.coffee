do (Backbone)->
  _sync = Backbone.sync

  Backbone.sync = (method, model, options = {})->
    baseUrl = options.url || _.result(model, 'url')
    options.url = if baseUrl then '/api/v1' + baseUrl
    token = sessionStorage.getItem 'api-token'

    if token
      options.headers =
        token: token

    _sync.apply(this, arguments)
