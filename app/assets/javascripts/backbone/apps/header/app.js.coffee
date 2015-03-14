@ExpertSystem.module 'HeaderApp', (HeaderApp, App, Backbone, Marionette, $, _) ->
  HeaderApp.on 'start', ->
    new HeaderApp.HeaderController(region: App.rootView.headerRegion)
