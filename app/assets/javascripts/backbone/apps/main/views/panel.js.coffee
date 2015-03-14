@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  activePrimitive = null
  App.reqres.setHandler('main:panel:primitive', -> activePrimitive)
  class MainApp.PanelView extends Marionette.ItemView
    className: 'panel-view'
    template: 'main/views/templates/panel'
    events:
      'click [data-control]': (event)->
        control_name = event.currentTarget.getAttribute('data-control')
        activePrimitive = control_name