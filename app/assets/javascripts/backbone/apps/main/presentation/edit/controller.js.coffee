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
#      @presentationView.presentationRegion.show @initCanvasView()
      new Presentation.PagesController document: @document, region: @presentationView.presentationRegion

      @presentationView.controlsRegion.show @initControlsView()
      @presentationView.pagesRegion.show @initPagesListView()

    showInfoView: (document)->
      infoRegion = @presentationView.infoRegion
      infoView = new Presentation.InfoView model: document
      @listenTo infoView, 'info:blur', (data)->
        @saveDocument attrs: data, immediately: true
      infoRegion.show infoView

    initCanvasView: ->
      canvasView = new Presentation.CanvasView
        model: @document.pages.at(0)
        presentationView: @presentationView
      @listenTo canvasView, 'canvas:change', @onCanvasChange
      canvasView

    initControlsView: ->
      controlsView = new Presentation.ControlsView()
      @listenTo controlsView, 'control:check', (control_name)->
        @presentationView.trigger 'presentation:primitive:select', control_name
      controlsView

    initPagesListView: ->
      pagesListView = new Presentation.PagesListView collection: @document.pages
      @listenTo pagesListView, 'click:add', ->
        @document.addNewPage().save()
      pagesListView

    onDocumentChange: (model, options)->
      @_startInputDocument = true
      @saveDocument()

    onCanvasChange: (model, content)->
      @savePage model, attrs: {content: content}


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

    savePage: (page, options = {})->
      page.set(options.attrs, {silent: true}) if options.attrs
      if App.request('viewer').isSignedIn()
        clearTimeout(@_pageTimeout) if @_pageTimeout
        if options.immediately
          page.savePage()
        @_pageTimeout = setTimeout =>
          page.savePage()
        , 1500


  Presentation