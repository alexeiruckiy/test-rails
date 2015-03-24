@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->

  class MainApp.PresentationController extends App.Controllers.Base
    initialize: (options = {})->
      { document } = options

      view = new MainApp.PresentationView(model: document)

      $.when(document.fetch()).done =>
        $.when(document.fetchPages()).done ->
          new MainApp.PagesController(document: document, region: view.pagesManageRegion)
        @show view