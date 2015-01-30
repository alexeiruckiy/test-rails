@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->
  class Presentation.EditController extends Marionette.Controller
    initialize: (options = {})->
      @document = options.document
      @listenTo @document, 'change', @onDocumentChange
      @document.fetchDocument =>
        @onDocumentFetch()
      @presentationView = options.presentationView
      @showInfoView @document
      @listenTo App.request('viewer'), 'user:successLogin', @saveDocument

    onDocumentFetch: ->
      new Presentation.PagesController(
        document: @document,
        region: @presentationView.presentationRegion,
      )
      @presentationView.controlsRegion.show(new Presentation.ControlsView())
      @presentationView.pagesRegion.show(@initPagesListView())

    showInfoView: (document)->
      infoRegion = @presentationView.infoRegion
      infoView = new Presentation.InfoView model: document
      @listenTo infoView, 'info:blur', (data)->
        @saveDocument attrs: data, immediately: true
      infoRegion.show infoView

    initPagesListView: ->
      pagesListView = new Presentation.PagesListView collection: @document.pages
      @listenTo pagesListView, 'click:add', ->
        @document.saveNewPage()
      pagesListView

    onDocumentChange: (model, options)->
      @_startInputDocument = true
      @saveDocument()

    saveDocument: (options = {})->
      return unless @_startInputDocument
      @document.set(options.attrs, {silent: true}) if options.attrs
      if App.request('viewer').isSignedIn()
        clearTimeout(@_documentTimeout) if @_documentTimeout
        if options.immediately
          @document.saveDocument()
        else
          @_documentTimeout = setTimeout =>
            @document.saveDocument()
          , 1500



  Presentation