@ExpertSystem.module 'MainApp.EditPresentation', (EditPresentation, App, Backbone, Marionette, $, _) ->

  class EditPresentation.View extends Marionette.LayoutView
    template: 'main/edit_presentation/templates/presentation-layout'
    className: 'edit-presentation-view'
    regions:
      pagesManageRegion: '#pages-manage-region'
      infoRegion: '#info-region'