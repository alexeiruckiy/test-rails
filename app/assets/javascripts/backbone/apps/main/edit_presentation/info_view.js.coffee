@ExpertSystem.module 'MainApp.EditPresentation', (EditPresentation, App, Backbone, Marionette, $, _) ->
  class EditPresentation.InfoView extends App.Views.Base
    template: 'main/edit_presentation/templates/info'
    className: 'info-view'
    bindings:
      '[data-field=name]': 'text:name'
      '[data-field=description]': 'text:description'
