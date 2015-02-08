@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  activePrimitive = null
  editState = false

  class MainApp.PagesController extends App.Controllers.Base
    initialize: (options={})->
      editState = options.editState
      @document = options.document
      @currentPage = options.document.pages.first()
      @view = new MainApp.PagesManageView()
      @listenTo(@view, 'render', @onPagesManageViewRender)
      @show(@view)

    onPagesManageViewRender: ->
      @pagesView = new MainApp.PagesView(model: @document)
      @listenTo(@pagesView, 'render', @showPage)
      @listenTo(@pagesView, 'page:change:click', @checkPage)
      @view.pagesRegion.show(@pagesView)

      @view.panelRegion.show(new MainApp.PanelView()) if editState
      @view.pagesListRegion.show(new MainApp.PagesListView(collection: @document.pages))

    checkPage: (is_left)->
      index = @document.pages.indexOf @currentPage
      index = if is_left then Math.max(0, --index) else Math.min(@document.pages.length - 1, ++index)
      page = @document.pages.at index
      unless @currentPage == page
        @currentPage = page
        page.fetch success: =>
          @showPage()

    showPage: ->
      canvasView = new MainApp.CanvasView(model: @currentPage)
      @listenTo(canvasView, 'canvas:change', @savePage)
      @pagesView.pageRegion.show(canvasView)

    savePage: (page, content = null)->
      page.set({content: content}, {silent: true}) if content
      if App.request('viewer').isSignedIn()
        clearTimeout(@_pageTimeout) if @_pageTimeout
        @_pageTimeout = setTimeout =>
          page.savePage()
        ,1500


  class MainApp.PagesManageView extends Marionette.LayoutView
    className: 'pages-manage-view'
    template: 'main/templates/manage'
    regions:
      pagesListRegion: '#pages-list-region'
      panelRegion: '#panel-region'
      pagesRegion: '#pages-region'


  class MainApp.PagesView extends Marionette.LayoutView
    className: 'pages-view'
    template: 'main/templates/pages'
    regions:
      pageRegion: '#page-region'
    events:
      'click .js-left,.js-right': (event)->
        @triggerMethod 'page:change:click', event.currentTarget.classList.contains('js-left')


  class MainApp.CanvasView extends Marionette.ItemView
    className: 'document-paper'
    events:
      'click' : 'onPaperClick'
    modelEvents:
      'change:content': ->
        @paper.fromJSON @model.get 'content'

    onRender: ->
      @paper = Raphael(@el, 520,390)
      @paper.fromJSON @model.get 'content'

    onPaperClick: (event)->
      return unless editState
      $target = $(event.currentTarget)
      offsetX = event.offsetX || event.clientX - $target.offset().left
      offsetY = event.offsetY || event.clientY - $target.offset().top
      switch activePrimitive
        when 'text'
          @paper.text offsetX, offsetY, 'qwerty'
        when 'figure'
          @paper.circle offsetX, offsetY, 40
      @trigger 'canvas:change', @model, @paper.toJSON()


    class MainApp.PanelView extends Marionette.ItemView
      className: 'panel-view'
      template: 'main/templates/panel'
      events:
        'click [data-control]': (event)->
          control_name = event.currentTarget.getAttribute('data-control')
          activePrimitive = control_name

    class MainApp.PagesListView extends Marionette.CompositeView
      template: 'main/templates/pages-list'
      childView: Marionette.ItemView.extend(template: 'main/templates/page')
      childViewContainer: '.pages'
      events:
        'click .js-add': -> @triggerMethod 'click:add'