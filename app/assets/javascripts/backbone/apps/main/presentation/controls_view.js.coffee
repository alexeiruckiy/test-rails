@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->
  class Presentation.ControlsView extends Marionette.ItemView
    template: 'main/presentation/templates/controls'
    events:
      'click [data-control]': (event)->
        control_name = event.currentTarget.getAttribute 'data-control'
        @triggerMethod 'control:check', control_name

  Presentation