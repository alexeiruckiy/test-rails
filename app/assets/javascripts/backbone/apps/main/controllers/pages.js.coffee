@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  editState = false
  class MainApp.PagesController extends App.Controllers.Base
    initialize: (options={})->
      { editState, @document } = options
      @currentPage = @document.pages.first()
      @view = new MainApp.PagesManageView()
      @listenTo(@view, 'render', @onPagesManageViewRender)
      @show(@view)

    onPagesManageViewRender: ->
      @pagesView = @initPagesView()
      @view.pagesRegion.show(@pagesView)

      @view.panelRegion.show(new MainApp.PanelView()) if editState

      @pagesListView = @initPagesListView()
      @view.pagesListRegion.show(@pagesListView)

    initPagesView: ->
      pagesView = new MainApp.PagesView(model: @document)
      @listenTo(pagesView, 'render', @showPage)
      @listenTo(pagesView, 'page:change:click', @checkPage)
      pagesView

    initPagesListView: ->
      pagesListView =  new MainApp.PagesListView(collection: @document.pages, editState: editState)
      @listenTo(pagesListView, 'add:click', @onPagesListAddClick) if editState
      pagesListView

    onPagesListAddClick: ->
      page = App.request('page')
      @savePage(page)

    checkPage: (is_left)->
      pages = @document.pages
      index = pages.indexOf(@currentPage)
      index = if is_left then Math.max(0, --index) else Math.min(pages.length - 1, ++index)
      page = pages.at(index)
      unless @currentPage == page
        @currentPage = page
        page.fetch(success: => @showPage())

    showPage: ->
      canvasView = new MainApp.CanvasView(model: @currentPage, editState: editState)
      @listenTo(canvasView, 'canvas:change', @onCanvasChange)
      @pagesView.pageRegion.show(canvasView)

    onCanvasChange: (page, content = null)->
      page.set({content: content}, {silent: true}) if content
      @savePage(page)

    savePage: (page)->
      if App.request('viewer').isSignedIn()
        clearTimeout(@_pageTimeout) if @_pageTimeout
        @_pageTimeout = setTimeout((=> @document.savePage(page)), 1500)