@ExpertSystem.module 'HeaderApp', (HeaderApp, App, Backbone, Marionette, $, _) ->
  App.addInitializer ->
    new HeaderApp.Controller(region: App.headerRegion)


