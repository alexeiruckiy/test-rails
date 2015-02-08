@ExpertSystem.module 'MainApp.NewPresentation', (NewPresentation, App, Backbone, Marionette, $, _) ->

  class NewPresentation.View extends App.Views.Base
    template: 'main/new_presentation/templates/new'
    className: 'new-presentation-view'
    events:
      'click [name=create]': ->
        @trigger('info:create', @model)

    bindings:
      '[data-field=name]': 'text:name'
      '[data-field=description]': 'text:description'

  NewPresentation