@ExpertSystem.module 'MainApp.NewPresentation', (NewPresentation, App, Backbone, Marionette, $, _) ->

  class NewPresentation.Controller extends App.Controllers.Base
    initialize: (options = {})->
      document = App.request('document')
      view = new NewPresentation.View(model: document)
      @listenTo(view, 'info:create', @createDocument)
      @show(view)

    createDocument: (document)->
      document.saveDocument {}, success: ->
        App.MainApp.router.navigate('presentations/' + document.id, trigger: true)

  NewPresentation