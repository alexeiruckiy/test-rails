@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.EditPresentationController extends App.Controllers.Base
    initialize: (options = {})->
      { @document } = options
      @register(@document)
      @view = new MainApp.EditPresentationView(model: @document)
      $.when(@document.fetch()).done =>
        $.when(@document.fetchPages()).done => @onDocumentPagesFetch()
        @onDocumentFetch()

      user = App.request('viewer')
      @listenTo(user, 'user:login:success', @onUserSuccessLogin)
      @show @view

    onDocumentFetch: ->
      infoView = new MainApp.InfoView(model: @document)
      infoView.once 'render', =>
        @listenTo(@document, 'change:name change:description', @onDocumentChange)
      @view.infoRegion.show(infoView)

    onDocumentPagesFetch: ->
      new MainApp.PagesController(document: @document, region: @view.pagesManageRegion, editState: true)

    onDocumentChange: ->
      clearTimeout(@_documentTimeout) if @_documentTimeout
      document = @document
      @_documentTimeout = setTimeout (-> document.save() if App.request('viewer').isSignedIn()), 1500

    onUserSuccessLogin: ->
      @document.saveDocument() if App.request('viewer').isSignedIn()

