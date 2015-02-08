@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->

  class Presentation.Controller extends App.Controllers.Base
    initialize: (options)->
      document = options.document
      view = new Presentation.View(model: document)
      @listenTo document, 'document:fetch', ->
        @show view
      @listenTo document, 'document:pages:fetch', ->
        new App.MainApp.PagesController(document: document, region: view.pagesManageRegion)
      document.fetchDocument()