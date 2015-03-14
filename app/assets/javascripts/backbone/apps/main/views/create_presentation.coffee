@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->

  class MainApp.CreatePresentationView extends App.Views.Base
    template: 'main/views/templates/new_presentation'
    className: 'new-presentation-view'
    events:
      'click [name=create]': ->
        @trigger('info:create', @model)

    bindings:
      '[data-field=name]': 'text:name'
      '[data-field=description]': 'text:description'