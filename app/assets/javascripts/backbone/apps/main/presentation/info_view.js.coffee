@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->
  class Presentation.InfoView extends App.Views.Base
    template: 'main/presentation/templates/info'
    className: 'info-block'
    events:
      'blur @ui.form_control': (event)->
        data = {}
        data[event.target.name] = event.target.value
        @trigger 'info:blur', data
      'click [name=create]': ->
        @trigger 'info:create', @model

    bindings:
      '[data-field=name]': 'text:name'
      '[data-field=description]': 'text:description'

  Presentation