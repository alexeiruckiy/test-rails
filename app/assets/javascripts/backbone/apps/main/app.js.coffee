@ExpertSystem.module 'MainApp',
  moduleClass: @ExpertSystem.Common.BaseModule
  define: (MainApp, App, Backbone, Marionette, $, _) ->
    class MainApp.Router extends Marionette.AppRouter
      appRoutes:
        '': 'showFrontPage'
        'presentations/new': 'newPresentation'
        'presentations/my': 'myPresentations'
        'presentations/:id': 'showPresentation'
        'presentations/:id/edit': 'editPresentation'
        'sign-up': 'signUp'

    Api =
      showFrontPage: ->
        MainApp.initController(MainApp.FrontController, region: App.rootView.mainRegion)

      newPresentation: ->
        if App.request('viewer').isSignedIn()
          MainApp.initController(MainApp.CreatePresentationController, region: App.rootView.mainRegion)
        else
          MainApp.router.navigate('')
          App.execute('show:alert', 'Not signed in')

      showPresentation: (id)->
        MainApp.initController(MainApp.PresentationController, region: App.rootView.mainRegion, document: App.request('document', id))

      editPresentation: (id)->
        if App.request('viewer').isSignedIn()
          MainApp.initController(MainApp.EditPresentationController, region: App.rootView.mainRegion, document: App.request('document', id))
        else
          MainApp.router.navigate('')
          App.execute('show:alert', 'Not signed in')

      myPresentations: ->
        if App.request('viewer').isSignedIn()
          MainApp.initController(MainApp.MyPresentationsController, region: App.rootView.mainRegion)
        else
          MainApp.router.navigate('')
          App.execute('show:alert', 'Not signed in')

      signUp: ->
        MainApp.initController(MainApp.SignUpController, region: App.rootView.mainRegion)

    MainApp.on 'start', ->
      MainApp.router = new MainApp.Router(controller: Api)



