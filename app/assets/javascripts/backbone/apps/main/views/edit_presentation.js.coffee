@ExpertSystem.module 'MainApp', (MainApp, App, Backbone, Marionette, $, _) ->

  class MainApp.EditPresentationView extends Marionette.LayoutView
    template: 'main/views/templates/edit_presentation'
    className: 'edit-presentation-view'
    regions:
      pagesManageRegion: '#pages-manage-region'
      infoRegion: '#info-region'