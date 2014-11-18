do (Marionette)->
  _.extend Marionette.Renderer,
    render: (template, data) ->
      path = @getTemplate(template)
      path data if path
    getTemplate: (template) ->
      return JST['backbone/apps/' + template] || JST['backbone/views/templates/' + template]