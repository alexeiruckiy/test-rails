@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.PagesView extends Marionette.LayoutView
    className: 'pages-view'
    template: 'main/views/templates/pages'
    regions:
      pageRegion: '#page-region'
    events:
      'click .js-left,.js-right': (event)->
        @triggerMethod 'page:change:click', event.currentTarget.classList.contains('js-left')