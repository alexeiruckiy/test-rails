@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->
  class Presentation.NewController extends App.Controllers.Base
    initialize: (options = {})->
      @show @initInfoView options.document

    createDocument: (document)->
      document.saveDocument {}, success: ->
        App.MainApp.router.navigate 'presentations/' + document.id, trigger: true

    initInfoView: (document)->
      infoView = new Presentation.InfoView model: document
      @listenTo infoView, 'info:create', @createDocument
      infoView

  Presentation