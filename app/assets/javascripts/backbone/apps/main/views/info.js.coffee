@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.InfoView extends App.Views.Base
    template: 'main/views/templates/info'
    className: 'info-view'
    bindings:
      '[data-field=name]': 'text:name'
      '[data-field=description]': 'text:description'