do (Backbone)->
  _sync = Backbone.sync

  Backbone.sync = (method, model, options = {})->
    baseUrl = options.url || _.result(model, 'url')
    options.url = if baseUrl then '/api/v1' + baseUrl

    token = $.cookie 'api_token'

    options.headers ||= {}
    options.headers.token = token if token
    options.headers['X-CSRF-Token'] = ExpertSystem.X_CSRF_TOKEN

    _sync.apply(@, arguments)
