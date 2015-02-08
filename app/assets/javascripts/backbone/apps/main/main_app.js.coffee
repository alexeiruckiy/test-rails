@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->

  class MainApp.Router extends Marionette.AppRouter
    appRoutes:
      '': 'showFrontPage'
      'presentations/new': 'newPresentation'
      'presentations/:id': 'showPresentation'
      'presentations/:id/edit': 'editPresentation'
      'sign-up': 'signUp'

  Api =
    showFrontPage: ->
      new MainApp.Front.Controller(region: App.mainRegion)

    newPresentation: ->
      new MainApp.NewPresentation.Controller(region: App.mainRegion)

    showPresentation: (id)->
       new MainApp.Presentation.Controller(region: App.mainRegion, document: App.request('document', id))

    editPresentation: (id)->
       new MainApp.EditPresentation.Controller(region: App.mainRegion, document: App.request('document', id))

    signUp: ->
      new MainApp.SignUp.Controller(region: App.mainRegion)

  App.addInitializer ->
    MainApp.router = new MainApp.Router(controller: Api)



