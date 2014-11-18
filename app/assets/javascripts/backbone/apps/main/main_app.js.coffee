@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class MainApp.Router extends Marionette.AppRouter
    appRoutes:
      '': 'showFrontPage'
      'presentations/new': 'newPresentation'
      'presentations/:id': 'showPresentation'
      'presentations/:id/edit': 'editPresentation'

  App.addInitializer ->
    MainApp.router = new MainApp.Router
      controller: new MainApp.Controller region: App.mainRegion


  MainApp



