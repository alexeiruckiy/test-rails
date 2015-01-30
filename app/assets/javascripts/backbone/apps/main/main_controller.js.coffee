@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.Controller extends App.Controllers.Base
    showFrontPage: ->
      @contentView = new Marionette.ItemView
        template: 'main/templates/front'
        className: 'front-wrapper'
      @show @contentView

    newPresentation: ->
      layoutView = @getLayoutView()
      layoutView.once 'render', ->
        new MainApp.Presentation.NewController
          region: @infoRegion
          document: App.request 'document'
      @show layoutView

    showPresentation: (id)->
      new MainApp.Presentation.ShowController
        region: @region
        document: App.request 'document', id

    editPresentation: (id)->
      layoutView = @getLayoutView(state: 'edit')
      layoutView.once 'render', ->
        new MainApp.Presentation.EditController
          document: App.request 'document', parseInt(id)
          presentationView: @
      @show layoutView


    getLayoutView: (options = {})->
      new MainApp.Presentation.LayoutView options

  MainApp