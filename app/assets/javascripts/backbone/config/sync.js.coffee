do (Backbone)->
  _sync = Backbone.sync

  Backbone.sync = (method, model, options = {})->
    options.headers ||= {}
    options.headers['X-CSRF-Token'] = ExpertSystem.X_CSRF_TOKEN
    _sync.apply(@, arguments)
