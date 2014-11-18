@ExpertSystem.module 'PopupApp', (PopupApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class PopupApp.Router extends Marionette.AppRouter
    appRoutes:
      'sign-up': 'signUp'

  App.addInitializer ->
    new PopupApp.Router
      controller: new PopupApp.Controller
                    region: App.popupRegion


  PopupApp