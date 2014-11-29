@ExpertSystem.module 'HeaderApp', (HeaderApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class HeaderApp.Router extends Marionette.AppRouter
    appRoutes:
      'sign-up': 'signUp'

  App.addInitializer ->
    new HeaderApp.Router controller: getController()

  getController = ()->
    unless HeaderApp.controller
      HeaderApp.controller = new HeaderApp.Controller region: App.headerRegion
    HeaderApp.controller

  HeaderApp.on 'start', ->
    controller = getController()
    controller.showHeader()

  HeaderApp



