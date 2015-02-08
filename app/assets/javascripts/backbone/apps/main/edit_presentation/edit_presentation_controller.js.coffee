@ExpertSystem.module 'MainApp.EditPresentation', (EditPresentation, App, Backbone, Marionette, $, _) ->
  class EditPresentation.Controller extends App.Controllers.Base
    initialize: (options = {})->
      @document = options.document
      @view = new EditPresentation.View(model: @document)
      @document.once('document:fetch', => @onDocumentFetch())
      @document.once('document:pages:fetch', => @onDocumentPagesFetch())
      @document.fetchDocument()

      user = App.request('viewer')
      @listenTo(user, 'user:login:success', @onUserSuccessLogin)
      @show @view

    onDocumentFetch: ->
      infoView = new EditPresentation.InfoView(model: @document)
      infoView.once 'render', =>
        @listenTo(@document, 'change:name change:description', @onDocumentChange)
      @view.infoRegion.show(infoView)

    onDocumentPagesFetch: ->
      new App.MainApp.PagesController(document: @document, region: @view.pagesManageRegion, editState: true)

    onDocumentChange: ->
      clearTimeout(@_documentTimeout) if @_documentTimeout
      document = @document
      @_documentTimeout = setTimeout (-> document.save() if App.request('viewer').isSignedIn()), 1500

    onUserSuccessLogin: ->
      @document.saveDocument() if App.request('viewer').isSignedIn()

