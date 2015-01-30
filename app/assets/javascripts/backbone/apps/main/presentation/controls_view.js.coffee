@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->
  App.reqres.setHandler('presentationView:primitive', -> activePrimitive)

  activePrimitive = null

  class Presentation.ControlsView extends Marionette.ItemView
    template: 'main/presentation/templates/controls'
    events:
      'click [data-control]': (event)->
        control_name = event.currentTarget.getAttribute('data-control')
        activePrimitive = control_name

  Presentation