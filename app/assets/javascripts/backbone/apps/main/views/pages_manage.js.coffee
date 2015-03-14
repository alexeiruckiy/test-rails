@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->
  class MainApp.PagesManageView extends Marionette.LayoutView
    className: 'pages-manage-view'
    template: 'main/views/templates/pages_manage'
    regions:
      pagesListRegion: '#pages-list-region'
      panelRegion: '#panel-region'
      pagesRegion: '#pages-region'