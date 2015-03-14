@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->

  class MainApp.CreatePresentationController extends App.Controllers.Base
    initialize: (options = {})->
      document = App.request('document')
      view = new MainApp.CreatePresentationView(model: document)
      @listenTo(view, 'info:create', @createDocument)
      @show(view)

    createDocument: (document)->
      document.saveDocument {}, success: ->
        MainApp.router.navigate('presentations/' + document.id, trigger: true)