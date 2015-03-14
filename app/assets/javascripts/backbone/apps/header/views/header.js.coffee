@ExpertSystem.module 'HeaderApp', (HeaderApp, App, Backbone, Marionette, $, _) ->
  class HeaderApp.HeaderView extends Marionette.LayoutView
    tagName: 'header'
    className: 'header-view'
    template: 'header/views/templates/header'
    regions:
      loginRegion: '#login-region'
    ui:
      items: '.js-navigation a'
      root: '.js-root-item'

    initialize: (options={})->
      @listenTo Backbone.history, 'all', (router, name, args)->
        @checkNavigationState(Backbone.history.fragment)

    checkNavigationState: (href)->
      href = '/' + href
      matched = @ui.items.filter(-> @pathname && @pathname != '/' && href.indexOf(@pathname) == 0)
      @ui.items.parent().removeClass('active')
      if matched.length
        relevant = null
        matched.each(-> relevant = @ if !relevant || relevant.pathname.split('/').length < @pathname.split('/').length)
        $(relevant).parentsUntil(@$el, 'li').addClass('active')
      else
        @ui.root.parent().addClass('active')