@ExpertSystem.module 'MainApp.Presentation', (Presentation, App, Backbone, Marionette, $, _) ->

  class Presentation.PagesController extends App.Controllers.Base
    initialize: (options)->
      @document = options.document
      @currentPage = options.document.pages.first()
      @pagesView = new Presentation.PagesView(model: options.document)
      @listenTo @pagesView, 'render', @showPage
      @listenTo @pagesView, 'page:change:click', @checkPage
      @show @pagesView

    checkPage: (is_left)->
      index = @document.pages.indexOf @currentPage
      index = if is_left then Math.max 0, --index else Math.min @document.pages.length - 1, ++index
      page = @document.pages.at index
      unless @currentPage == page
        @currentPage = page
        page.fetch success: =>
          @showPage()

    showPage: ->
      canvasView = new Presentation.CanvasView(model: @currentPage)
      @listenTo canvasView, 'canvas:change', @savePage
      @pagesView.pageRegion.show(canvasView)

    savePage: (page, content = null)->
      page.set({content: content}, {silent: true}) if content
      if App.request('viewer').isSignedIn()
        clearTimeout(@_pageTimeout) if @_pageTimeout
        @_pageTimeout = setTimeout =>
          page.savePage()
        ,1500

  class Presentation.PagesView extends Marionette.LayoutView
    className: 'pages-view'
    template: 'main/presentation/templates/pages'
    regions:
      pageRegion: '#page-region'
      indicatorRegion: '#page-indicator-region'
    events:
      'click .js-left,.js-right': (event)->
        @triggerMethod 'page:change:click', event.currentTarget.classList.contains('js-left')

  Presentation